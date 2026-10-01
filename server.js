const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
app.use(express.json());
app.use(cors());

// Configuración de la conexión a tu base de datos local
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',      // Cambia esto si tienes otro usuario en XAMPP/WampServer
    password: '',      // Pon tu contraseña si la tienes configurada
    database: 'lucimakeup_db'
});

db.connect((err) => {
    if (err) {
        console.error('Error al conectar a la base de datos:', err);
        return;
    }
    console.log('Conectado exitosamente a la base de datos lucimakeup_db');
});

// Ruta API de prueba para obtener los productos
app.get('/api/productos', (req, res) => {
    db.query('SELECT * FROM producto', (err, results) => {
        if (err) {
            res.status(500).json({ error: 'Error al consultar los productos' });
        } else {
            res.json(results);
        }
    });
});

// Iniciar el servidor en el puerto 3000
const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Servidor de API corriendo en http://localhost:${PORT}`);
});