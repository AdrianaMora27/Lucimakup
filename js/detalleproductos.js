/**
 * Lógica avanzada y blindada para el detalle dinámico de productos y adición al carrito - Lucimakeup Store
 * Conectado directamente a la API REST (MySQL) y alineado con Cuidado Personal y Maquillaje
 */

document.addEventListener("DOMContentLoaded", async () => {
    // 1. Obtener los parámetros de la URL de forma segura
    const parametrosURL = new URLSearchParams(window.location.search);
    const idBruto = parametrosURL.get("id");

    // 🛡️ BLINDAJE: Validar estrictamente que el ID de la URL sea numérico entero positivo
    const productoIdURL = /^\d+$/.test(idBruto) ? parseInt(idBruto, 10) : null;

    const contenedorDetalle = document.getElementById("detalle-producto") || document.querySelector('.producto-detalle');

    if (!productoIdURL) {
        if (contenedorDetalle) {
            contenedorDetalle.innerHTML = `
                <div style="grid-column: 1 / -1; text-align: center; padding: 4rem;">
                    <h2 style="color: #880e2f; font-size: 3rem;">⚠ Identificador inválido</h2>
                    <p style="font-size: 1.8rem; margin: 2rem 0;">El parámetro del producto en la URL no es válido.</p>
                    <a href="categorias.html" class="boton" style="display: inline-block; width: auto; padding: 1rem 3rem; text-decoration: none;">Ir al Catálogo</a>
                </div>
            `;
        }
        return;
    }

    try {
        // 2. Petición directa al backend por ID (Aprovecha la ruta GET /api/productos/:id de server.js)
        const respuesta = await fetch(`http://localhost:3000/api/productos/${productoIdURL}`);
        
        if (!respuesta.ok) {
            throw new Error('Producto no encontrado en el servidor');
        }

        const productoActual = await respuesta.json();

        if (productoActual && productoActual.idProducto) {
            // 3. Actualizar los elementos del DOM dinámicamente de forma segura
            const imagenEl = document.getElementById("imagen-producto");
            const nombreEl = document.getElementById("nombre-producto");
            const precioEl = document.getElementById("precio-producto");
            const descEl = document.getElementById("descripcion-producto");
            const inputIdHidden = document.getElementById("producto-id");

            // Asegurar que la ruta de la imagen proveniente de MySQL sea válida
            const rutaImagen = productoActual.imagen && productoActual.imagen.trim() !== "" 
                ? productoActual.imagen.trim() 
                : 'img/default.jpg';

            if (imagenEl) {
                imagenEl.src = rutaImagen;
                imagenEl.alt = sanitizarTexto(productoActual.Nombre_Producto);
            }
            if (nombreEl) nombreEl.textContent = productoActual.Nombre_Producto;
            if (precioEl) precioEl.textContent = `$${Number(productoActual.Precio_Producto).toLocaleString('es-CO')} COP`;
            if (descEl) descEl.textContent = productoActual.descripcion_producto || 'Sin descripción detallada disponible.';
            if (inputIdHidden) inputIdHidden.value = productoActual.idProducto;

            // Actualizar de forma segura el título de la pestaña del navegador
            document.title = `${sanitizarTexto(productoActual.Nombre_Producto)} - Lucimakeup Store`;

            // Si la vista utiliza un contenedor dinámico vacío en lugar de IDs separados
            if (contenedorDetalle && !imagenEl) {
                contenedorDetalle.innerHTML = `
                    <div class="producto-imagen-grande">
                        <img src="${rutaImagen}" alt="${sanitizarTexto(productoActual.Nombre_Producto)}">
                    </div>
                    <div class="producto-info-detalle">
                        <h1>${sanitizarTexto(productoActual.Nombre_Producto)}</h1>
                        <p class="precio-detalle">$${Number(productoActual.Precio_Producto).toLocaleString('es-CO')} COP</p>
                        <p class="descripcion-detalle">${sanitizarTexto(productoActual.descripcion_producto || 'Sin descripción.')}</p>
                        <p class="stock-detalle">Disponibles: <strong>${productoActual.Stock_Producto} unidades</strong></p>
                        
                        <div class="grupo-cantidad">
                            <label for="cantidad-producto">Cantidad:</label>
                            <input type="number" id="cantidad-producto" class="carrito-item__cantidad" value="1" min="1" max="${productoActual.Stock_Producto}">
                        </div>

                        <button class="btn-agregar-carrito boton-checkout" data-id="${productoActual.idProducto}">Añadir al carrito</button>
                    </div>
                `;
            }

            // ==========================================
            // 4. LÓGICA DE AÑADIR AL CARRITO Y REDIRECCIÓN BLINDADA
            // ==========================================
            const btnAgregar = document.querySelector('.btn-agregar-carrito') || document.querySelector('.boton-checkout') || document.querySelector('#agregar-carrito') || document.querySelector('button');
            const inputCantidad = document.getElementById('cantidad-producto') || document.querySelector('input[type="number"]');

            // 🛡️ BLINDAJE EN TIEMPO REAL: Control estricto del input de cantidad
            if (inputCantidad) {
                const stockMaximo = Number(productoActual.Stock_Producto) || 20;
                inputCantidad.max = stockMaximo;

                inputCantidad.addEventListener('input', (e) => {
                    let val = parseInt(e.target.value, 10);
                    if (isNaN(val) || val < 1) {
                        e.target.value = 1;
                    } else if (val > stockMaximo) {
                        e.target.value = stockMaximo; // Bloquea superar el stock disponible en MySQL
                    }
                });
            }

            if (btnAgregar) {
                btnAgregar.addEventListener('click', (e) => {
                    e.preventDefault(); 

                    let cantidadSeleccionada = 1;
                    const stockMaximo = Number(productoActual.Stock_Producto) || 20;

                    if (inputCantidad) {
                        cantidadSeleccionada = parseInt(inputCantidad.value, 10) || 1;
                        if (cantidadSeleccionada < 1) cantidadSeleccionada = 1;
                        if (cantidadSeleccionada > stockMaximo) cantidadSeleccionada = stockMaximo;
                    }

                    // Armar el objeto seguro del producto a guardar
                    const itemCarrito = {
                        id: productoActual.idProducto,
                        nombre: productoActual.Nombre_Producto,
                        precio: Number(productoActual.Precio_Producto),
                        imagen: rutaImagen,
                        cantidad: cantidadSeleccionada
                    };

                    // Recuperar carrito actual del localStorage o iniciar uno vacío
                    let carrito = JSON.parse(localStorage.getItem('lucimakeup_carrito')) || [];

                    // Verificar si el producto ya existe en el carrito para sumar la cantidad
                    const indexExistente = carrito.findIndex(item => Number(item.id) === Number(itemCarrito.id));
                    
                    if (indexExistente >= 0) {
                        carrito[indexExistente].cantidad += itemCarrito.cantidad;
                        if (carrito[indexExistente].cantidad > stockMaximo) {
                            carrito[indexExistente].cantidad = stockMaximo;
                        }
                    } else {
                        carrito.push(itemCarrito);
                    }

                    // Guardar de vuelta en el localStorage
                    localStorage.setItem('lucimakeup_carrito', JSON.stringify(carrito));

                    // Redirigir de inmediato a la vista del carrito
                    window.location.href = 'carrito.html';
                });
            }

        } else {
            mostrarErrorProducto(contenedorDetalle);
        }

    } catch (error) {
        console.error("Error al consultar el detalle del producto:", error);
        mostrarErrorProducto(contenedorDetalle);
    }
});

function mostrarErrorProducto(contenedor) {
    if (contenedor) {
        contenedor.innerHTML = `
            <div style="grid-column: 1 / -1; text-align: center; padding: 4rem;">
                <h2 style="color: #880e2f; font-size: 3rem;">⚠ Producto no encontrado</h2>
                <p style="font-size: 1.8rem; margin: 2rem 0;">Lo sentimos, el producto que buscas no existe o fue retirado del catálogo.</p>
                <a href="categorias.html" class="boton" style="display: inline-block; width: auto; padding: 1rem 3rem; text-decoration: none;">Volver al Catálogo</a>
            </div>
        `;
    }
}

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