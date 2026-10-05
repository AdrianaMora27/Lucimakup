const express = require('express');
const mysql = require('mysql2');
const cors = express.require ? require('cors') : require('cors');

const app = express();
app.use(express.json());
app.use(cors());

// Configuración de la conexión a la base de datos local (phpMyAdmin)
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'lucimakeup_db'
});

db.connect((err) => {
    if (err) {
        console.error('❌ Error al conectar a la base de datos:', err);
        return;
    }
    console.log('✅ Conectado exitosamente a la base de datos lucimakeup_db');
});

// ==========================================
// 1. MÓDULO DE PRODUCTOS (CATÁLOGO PÚBLICO)
// ==========================================
app.get('/api/productos', (req, res) => {
    db.query('SELECT * FROM producto', (err, results) => {
        if (err) {
            console.error('Error al consultar los productos:', err);
            return res.status(500).json({ error: 'Error al consultar los productos' });
        }
        res.json(results);
    });
});

// ==========================================
// 2. MÓDULO DE AUTENTICACIÓN (REGISTRO Y LOGIN)
// ==========================================
app.post('/api/registro', (req, res) => {
    const { nombre, apellido, telefono, email, password } = req.body;

    if (!nombre || !email || !password) {
        return res.status(400).json({ exito: false, mensaje: 'Todos los campos obligatorios son requeridos.' });
    }

    const query = 'INSERT INTO cliente (Nombre, Apellido, telefono, Email, Password, fecha_registro) VALUES (?, ?, ?, ?, ?, NOW())';

    db.query(query, [nombre, apellido || '', telefono || '', email, password], (err, result) => {
        if (err) {
            console.error('Error al registrar cliente:', err);
            return res.status(500).json({ exito: false, mensaje: 'El correo ya está registrado o hubo un error en la base de datos.' });
        }
        res.status(200).json({ 
            exito: true, 
            mensaje: '¡Cliente registrado exitosamente en la base de datos!', 
            idCliente: result.insertId 
        });
    });
});

app.post('/api/login', (req, res) => {
    const { email, password } = req.body;

    if (!email || !password) {
        return res.status(400).json({ exito: false, mensaje: 'Ingresa correo y contraseña.' });
    }

    const query = 'SELECT * FROM cliente WHERE Email = ? AND Password = ?';

    db.query(query, [email, password], (err, results) => {
        if (err) {
            console.error('Error en el login:', err);
            return res.status(500).json({ exito: false, mensaje: 'Error en el servidor.' });
        }

        if (results.length > 0) {
            res.status(200).json({ 
                exito: true, 
                mensaje: '¡Inicio de sesión exitoso!',
                usuario: { 
                    id: results[0].idCliente, 
                    nombre: results[0].Nombre, 
                    email: results[0].Email 
                }
            });
        } else {
            res.status(401).json({ exito: false, mensaje: 'Correo o contraseña incorrectos.' });
        }
    });
});

app.post('/api/contacto', (req, res) => {
    const { nombre, telefono, correo, mensaje } = req.body;
    
    const query = 'INSERT INTO mensajes_contacto (nombre, telefono, correo, mensaje) VALUES (?, ?, ?, ?)';
    db.query(query, [nombre, telefono, correo, mensaje], (err, result) => {
        if (err) {
            console.error('Error al guardar el mensaje:', err);
            return res.status(500).json({ exito: false, mensaje: 'Error en el servidor' });
        }
        res.json({ exito: true, mensaje: '¡Mensaje guardado con éxito!' });
    });
});

// ==========================================
// 3. MÓDULO DE PEDIDOS / CARRITO (CHECKOUT)
// ==========================================
app.post('/api/pedido', (req, res) => {
    const { subtotal, costo_envio, total, cliente_id, items } = req.body;

    if (!total || !items || items.length === 0) {
        return res.status(400).json({ exito: false, mensaje: 'El carrito está vacío o faltan datos del pedido.' });
    }

    const clienteFinal = cliente_id ? cliente_id : 1; 

    // Columnas exactas de la tabla pedido
    const queryPedido = `
        INSERT INTO pedido (fecha, subtotal, impuesto, costo_envio, total, Estado, Cliente_idCliente) 
        VALUES (NOW(), ?, 0.00, ?, ?, 'Procesando', ?)
    `;

    const subtotalFinal = subtotal || total;
    const envioFinal = costo_envio || 0;

    db.query(queryPedido, [subtotalFinal, envioFinal, total, clienteFinal], (err, resultadoPedido) => {
        if (err) {
            console.error('Error al procesar la cabecera del pedido:', err);
            return res.status(500).json({ exito: false, mensaje: 'Error al guardar el pedido en la base de datos.' });
        }

        const idPedidoGenerado = resultadoPedido.insertId;

        const queriesDetalle = items.map(item => {
            const idProd = item.idProducto || item.id || 1;
            const cant = Number(item.cantidad) || 1;
            const precioUnit = Number(item.Precio_Producto || item.precio || item.precioOriginal) || 0;
            const subtotalItem = cant * precioUnit;

            return new Promise((resolve, reject) => {
                // Columnas exactas de la tabla detallepedido
                const q = `
                    INSERT INTO detallepedido (Producto_idProducto, Pedido_idPedido, precio_Unitario, cantidad, SubTotal) 
                    VALUES (?, ?, ?, ?, ?)
                `;
                db.query(q, [idProd, idPedidoGenerado, precioUnit, cant, subtotalItem], (errDet) => {
                    if (errDet) reject(errDet);
                    else resolve();
                });
            });
        });

        Promise.all(queriesDetalle)
            .then(() => {
                res.status(200).json({ 
                    exito: true, 
                    mensaje: '¡Pedido y detalles registrados con éxito en la base de datos!', 
                    idPedido: idPedidoGenerado 
                });
            })
            .catch(errDetalle => {
                console.error('Error al guardar los detalles del pedido:', errDetalle);
                res.status(500).json({ exito: false, mensaje: 'Pedido creado, pero falló el registro de los productos detalle.' });
            });
    });
});

// ==========================================
// 4. MÓDULO DE ADMINISTRADOR (CRUD PRODUCTOS)
// ==========================================
app.post('/api/admin/productos', (req, res) => {
    const { Nombre_Producto, descripcion_producto, Precio_Producto, Stock_Producto, Categoria_idCategoria, imagen } = req.body;
    const query = 'INSERT INTO producto (Nombre_Producto, descripcion_producto, Precio_Producto, Stock_Producto, Categoria_idCategoria, imagen) VALUES (?, ?, ?, ?, ?, ?)';

    db.query(query, [Nombre_Producto, descripcion_producto, Precio_Producto, Stock_Producto, Categoria_idCategoria, imagen], (err, result) => {
        if (err) {
            console.error('Error al agregar producto:', err);
            return res.status(500).json({ exito: false, mensaje: 'Error al guardar el producto.' });
        }
        res.status(200).json({ exito: true, mensaje: '¡Producto agregado por el administrador!', idProducto: result.insertId });
    });
});

app.put('/api/admin/productos/:id', (req, res) => {
    const { id } = req.params;
    const { Nombre_Producto, descripcion_producto, Precio_Producto, Stock_Producto, Categoria_idCategoria, imagen } = req.body;
    const query = 'UPDATE producto SET Nombre_Producto = ?, descripcion_producto = ?, Precio_Producto = ?, Stock_Producto = ?, Categoria_idCategoria = ?, imagen = ? WHERE idProducto = ?';

    db.query(query, [Nombre_Producto, descripcion_producto, Precio_Producto, Stock_Producto, Categoria_idCategoria, imagen, id], (err, result) => {
        if (err) {
            console.error('Error al actualizar:', err);
            return res.status(500).json({ exito: false, mensaje: 'Error al actualizar.' });
        }
        res.status(200).json({ exito: true, mensaje: '¡Producto actualizado con éxito!' });
    });
});

app.delete('/api/admin/productos/:id', (req, res) => {
    const { id } = req.params;
    const query = 'DELETE FROM producto WHERE idProducto = ?';

    db.query(query, [id], (err, result) => {
        if (err) {
            console.error('Error al eliminar:', err);
            return res.status(500).json({ exito: false, mensaje: 'Error al eliminar.' });
        }
        res.status(200).json({ exito: true, mensaje: '¡Producto eliminado!' });
    });
});

const PORT = 3000;
app.listen(PORT, () => {
    console.log(`🚀 Servidor de API corriendo en http://localhost:${PORT}`);
});