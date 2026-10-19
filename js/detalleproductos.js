/**
 * Lógica avanzada y blindada para el detalle dinámico de productos y adición al carrito - Lucimakeup Store
 */

document.addEventListener("DOMContentLoaded", () => {
    // 1. Obtener los parámetros de la URL de forma segura
    const parametrosURL = new URLSearchParams(window.location.search);
    const idBruto = parametrosURL.get("id");

    // 🛡️ BLINDAJE: Validar estrictamente que el ID de la URL sea numérico entero positivo
    const idA_Buscar = /^\d+$/.test(idBruto) ? Number(idBruto) : 101;

    // 3. Buscar el producto directamente en el arreglo global 'productos' (cargado desde productos.js)
    let productoActual = null;
    if (typeof productos !== 'undefined' && Array.isArray(productos)) {
        productoActual = productos.find(p => Number(p.idProducto) === idA_Buscar);
    }

    if (productoActual) {
        // 4. Actualizar los elementos del DOM dinámicamente de forma segura
        const imagenEl = document.getElementById("imagen-producto");
        const nombreEl = document.getElementById("nombre-producto");
        const precioEl = document.getElementById("precio-producto");
        const descEl = document.getElementById("descripcion-producto");
        const inputIdHidden = document.getElementById("producto-id");

        if (imagenEl) {
            imagenEl.src = productoActual.imagen;
            imagenEl.alt = sanitizarTexto(productoActual.Nombre_Producto);
        }
        if (nombreEl) nombreEl.textContent = productoActual.Nombre_Producto;
        if (precioEl) precioEl.textContent = `$${Number(productoActual.Precio_Producto).toLocaleString('es-CO')} COP`;
        if (descEl) descEl.textContent = productoActual.descripcion_producto;
        if (inputIdHidden) inputIdHidden.value = productoActual.idProducto;

        // Actualizar de forma segura el título de la pestaña del navegador
        document.title = `${sanitizarTexto(productoActual.Nombre_Producto)} - Lucimakeup Store`;

        // ==========================================
        // 5. LÓGICA DE AÑADIR AL CARRITO Y REDIRECCIÓN BLINDADA
        // ==========================================
        const btnAgregar = document.querySelector('.boton-checkout') || document.querySelector('#agregar-carrito') || document.querySelector('button');
        const inputCantidad = document.querySelector('input[type="number"]');

        // 🛡️ BLINDAJE EN TIEMPO REAL: Control estricto del input de cantidad
        if (inputCantidad) {
            inputCantidad.addEventListener('input', (e) => {
                let val = parseInt(e.target.value, 10);
                const stockMaximo = productoActual.Stock_Producto || 20; // Stock por defecto si no está definido
                if (isNaN(val) || val < 1) {
                    e.target.value = 1;
                } else if (val > stockMaximo) {
                    e.target.value = stockMaximo; // Bloquea superar el stock disponible
                }
            });
        }

        if (btnAgregar) {
            btnAgregar.addEventListener('click', (e) => {
                e.preventDefault(); 

                // Obtener cantidad seleccionada asegurando rangos válidos
                let cantidadSeleccionada = 1;
                if (inputCantidad) {
                    cantidadSeleccionada = parseInt(inputCantidad.value, 10) || 1;
                    if (cantidadSeleccionada < 1) cantidadSeleccionada = 1;
                    const stockMaximo = productoActual.Stock_Producto || 20;
                    if (cantidadSeleccionada > stockMaximo) cantidadSeleccionada = stockMaximo;
                }

                // Armar el objeto seguro del producto a guardar
                const itemCarrito = {
                    id: productoActual.idProducto,
                    nombre: productoActual.Nombre_Producto,
                    precio: Number(productoActual.Precio_Producto),
                    imagen: productoActual.imagen,
                    cantidad: cantidadSeleccionada
                };

                // Recuperar carrito actual del localStorage o iniciar uno vacío
                let carrito = JSON.parse(localStorage.getItem('lucimakeup_carrito')) || [];

                // Verificar si el producto ya existe en el carrito para sumar la cantidad de forma segura
                const indexExistente = carrito.findIndex(item => Number(item.id) === Number(itemCarrito.id));
                
                if (indexExistente >= 0) {
                    carrito[indexExistente].cantidad += itemCarrito.cantidad;
                    const stockMaximo = productoActual.Stock_Producto || 20;
                    if (carrito[indexExistente].cantidad > stockMaximo) {
                        carrito[indexExistente].cantidad = stockMaximo;
                    }
                } else {
                    carrito.push(itemCarrito);
                }

                // Guardar de vuelta en el localStorage de forma segura
                localStorage.setItem('lucimakeup_carrito', JSON.stringify(carrito));

                // Redirigir de inmediato a la vista del carrito
                window.location.href = 'carrito.html';
            });
        }

    } else {
        // Si el ID no existe en la base de datos o es inválido
        const contenedorDetalle = document.getElementById("detalle-producto") || document.querySelector('.producto-detalle');
        if (contenedorDetalle) {
            contenedorDetalle.innerHTML = `
                <div style="grid-column: 1 / -1; text-align: center; padding: 4rem;">
                    <h2 style="color: #880e2f; font-size: 3rem;">⚠ Producto no encontrado</h2>
                    <p style="font-size: 1.8rem; margin: 2rem 0;">Lo sentimos, el producto que buscas no existe o fue retirado del catálogo.</p>
                    <a href="index.html" class="boton" style="display: inline-block; width: auto; padding: 1rem 3rem; text-decoration: none;">Volver al Inicio</a>
                </div>
            `;
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