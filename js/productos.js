/**
 * Lógica dinámica y blindada de detalles de productos y carrito - Lucimakeup Store
 * Conectada al backend local (MySQL)
 */

document.addEventListener('DOMContentLoaded', async () => {
    const parametrosURL = new URLSearchParams(window.location.search);
    const idBruto = parametrosURL.get('id');

    // 🛡️ BLINDAJE: Validar estrictamente que el ID de la URL sea numérico entero positivo
    const productoIdURL = /^\d+$/.test(idBruto) ? parseInt(idBruto, 10) : null;

    const contenedorDetalle = document.querySelector('.producto-detalle');

    if (!productoIdURL) {
        if (contenedorDetalle) {
            contenedorDetalle.innerHTML = `<h2>Identificador de producto inválido.</h2>`;
        }
        return;
    }

    try {
        // Consultar los productos directamente desde el servidor backend (MySQL)
        const respuesta = await fetch('http://localhost:3000/api/productos');
        const resultado = await respuesta.json();
        const productosDB = Array.isArray(resultado) ? resultado : (resultado.productos || []);

        const productoEncontrado = productosDB.find(p => Number(p.idProducto) === productoIdURL);

        const imagenEl = document.getElementById("imagen-producto");
        const nombreEl = document.getElementById("nombre-producto");
        const precioEl = document.getElementById("precio-producto");
        const descEl = document.getElementById("descripcion-producto");

        if (productoEncontrado) {
            // Si el HTML usa IDs estáticos independientes:
            if (imagenEl) {
                imagenEl.src = productoEncontrado.imagen || 'img/default.jpg';
                imagenEl.alt = sanitizarTexto(productoEncontrado.Nombre_Producto);
            }
            if (nombreEl) nombreEl.textContent = productoEncontrado.Nombre_Producto;
            if (precioEl) precioEl.textContent = `$${Number(productoEncontrado.Precio_Producto).toLocaleString('es-CO')} COP`;
            if (descEl) descEl.textContent = productoEncontrado.descripcion_producto;

            // Si el HTML usa el contenedor dinámico con clase .producto-detalle:
            if (contenedorDetalle && !imagenEl) {
                contenedorDetalle.innerHTML = `
                    <div class="producto-imagen-grande">
                        <img src="${productoEncontrado.imagen || 'img/default.jpg'}" alt="${sanitizarTexto(productoEncontrado.Nombre_Producto)}">
                    </div>
                    <div class="producto-info-detalle">
                        <h1>${sanitizarTexto(productoEncontrado.Nombre_Producto)}</h1>
                        <p class="precio-detalle">$${Number(productoEncontrado.Precio_Producto).toLocaleString('es-CO')} COP</p>
                        <p class="descripcion-detalle">${sanitizarTexto(productoEncontrado.descripcion_producto)}</p>
                        <p class="stock-detalle">Disponibles: <strong>${productoEncontrado.Stock_Producto} unidades</strong></p>
                        
                        <div class="grupo-cantidad">
                            <label for="cantidad-producto">Cantidad:</label>
                            <input type="number" id="cantidad-producto" class="carrito-item__cantidad" value="1" min="1" max="${productoEncontrado.Stock_Producto}">
                        </div>

                        <button class="btn-agregar-carrito boton-checkout" data-id="${productoEncontrado.idProducto}">Añadir al carrito</button>
                    </div>
                `;
            }

            // 🛡️ BLINDAJE EN TIEMPO REAL: Control estricto del input de cantidad
            const inputCantidad = document.getElementById('cantidad-producto') || document.querySelector('input[type="number"]');
            if (inputCantidad) {
                inputCantidad.addEventListener('input', (e) => {
                    let val = parseInt(e.target.value, 10);
                    if (isNaN(val) || val < 1) {
                        e.target.value = 1;
                    } else if (val > productoEncontrado.Stock_Producto) {
                        e.target.value = productoEncontrado.Stock_Producto; // No permite superar el stock real de MySQL
                    }
                });
            }

            // Funcionalidad unificada para el botón de agregar al carrito
            const botonAgregar = document.querySelector('.btn-agregar-carrito') || document.querySelector('.boton-checkout');
            if (botonAgregar) {
                botonAgregar.addEventListener('click', (e) => {
                    e.preventDefault();
                    let cantidadSeleccionada = inputCantidad ? parseInt(inputCantidad.value, 10) : 1;

                    if (isNaN(cantidadSeleccionada) || cantidadSeleccionada < 1) {
                        cantidadSeleccionada = 1;
                    } else if (cantidadSeleccionada > productoEncontrado.Stock_Producto) {
                        cantidadSeleccionada = productoEncontrado.Stock_Producto;
                    }

                    let carrito = JSON.parse(localStorage.getItem('lucimakeup_carrito')) || [];
                    
                    const indexExistente = carrito.findIndex(item => Number(item.id) === Number(productoEncontrado.idProducto));
                    if (indexExistente >= 0) {
                        carrito[indexExistente].cantidad += cantidadSeleccionada;
                        if (carrito[indexExistente].cantidad > productoEncontrado.Stock_Producto) {
                            carrito[indexExistente].cantidad = productoEncontrado.Stock_Producto;
                        }
                    } else {
                        carrito.push({
                            id: productoEncontrado.idProducto,
                            nombre: productoEncontrado.Nombre_Producto,
                            precio: Number(productoEncontrado.Precio_Producto),
                            imagen: productoEncontrado.imagen || 'img/default.jpg',
                            cantidad: cantidadSeleccionada
                        });
                    }
                    
                    localStorage.setItem('lucimakeup_carrito', JSON.stringify(carrito));
                    window.location.href = 'carrito.html';
                });
            }
        } else {
            if (contenedorDetalle) {
                contenedorDetalle.innerHTML = `<h2>Lo sentimos, el producto no fue encontrado en la base de datos.</h2>`;
            }
        }

    } catch (error) {
        console.error("Error al conectar con el servidor backend para el detalle del producto:", error);
        if (contenedorDetalle) {
            contenedorDetalle.innerHTML = `<h2>Error de conexión con el servidor local.</h2>`;
        }
    }
});

/**
 * 🛡️ Función auxiliar de Sanitización para prevenir ataques XSS
 */
function sanitizarTexto(texto) {
    if (!texto) return "";
    return texto
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#x27;")
        .replace(/\//g, "&#x2F;");
}