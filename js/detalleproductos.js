/**
 * Lógica definitiva para el detalle de productos y adición al carrito - Lucimakeup Store
 */

document.addEventListener("DOMContentLoaded", async () => {
    const parametrosURL = new URLSearchParams(window.location.search);
    const idBruto = parametrosURL.get("id");

    // Validar estrictamente que el ID de la URL sea numérico
    const productoIdURL = /^\d+$/.test(idBruto) ? parseInt(idBruto, 10) : null;
    const contenedorDetalle = document.getElementById("detalle-producto");

    if (!productoIdURL) {
        mostrarErrorProducto(contenedorDetalle);
        return;
    }

    try {
        const respuesta = await fetch(`http://localhost:3000/api/productos/${productoIdURL}`);
        
        if (!respuesta.ok) {
            throw new Error('Producto no encontrado en el servidor');
        }

        const productoActual = await respuesta.json();

        if (productoActual && productoActual.idProducto) {
            // Referencias directas a los elementos de tu HTML
            const imagenEl = document.getElementById("imagen-producto");
            const nombreEl = document.getElementById("nombre-producto");
            const precioEl = document.getElementById("precio-producto");
            const descEl = document.getElementById("descripcion-producto");
            const inputIdHidden = document.getElementById("producto-id");
            const inputCantidad = document.getElementById("cantidad");
            const btnAgregar = document.getElementById("btn-agregar-carrito");

            const rutaImagen = productoActual.imagen && productoActual.imagen.trim() !== "" 
                ? productoActual.imagen.trim() 
                : 'img/default.jpg';

            // Rellenar datos en el DOM
            if (imagenEl) {
                imagenEl.src = rutaImagen;
                imagenEl.alt = sanitizarTexto(productoActual.Nombre_Producto);
            }
            if (nombreEl) nombreEl.textContent = productoActual.Nombre_Producto;
            if (precioEl) precioEl.textContent = `$${Number(productoActual.Precio_Producto).toLocaleString('es-CO')} COP`;
            if (descEl) descEl.textContent = productoActual.descripcion_producto || 'Sin descripción detallada disponible.';
            if (inputIdHidden) inputIdHidden.value = productoActual.idProducto;

            document.title = `${sanitizarTexto(productoActual.Nombre_Producto)} - Lucimakeup Store`;

            // Control de stock en el input de cantidad
            const stockMaximo = Number(productoActual.Stock_Producto) || 20;
            if (inputCantidad) {
                inputCantidad.max = stockMaximo;
                inputCantidad.value = 1;

                inputCantidad.addEventListener('input', (e) => {
                    let val = parseInt(e.target.value, 10);
                    if (isNaN(val) || val < 1) {
                        e.target.value = 1;
                    } else if (val > stockMaximo) {
                        e.target.value = stockMaximo;
                    }
                });
            }

            // Evento funcional del botón "Añadir al carrito"
            if (btnAgregar) {
                // Limpiar eventos previos para evitar duplicidad
                const nuevoBtn = btnAgregar.cloneNode(true);
                btnAgregar.parentNode.replaceChild(nuevoBtn, btnAgregar);

                nuevoBtn.addEventListener('click', (e) => {
                    e.preventDefault();

                    let cantidadSeleccionada = 1;
                    if (inputCantidad) {
                        cantidadSeleccionada = parseInt(inputCantidad.value, 10) || 1;
                        if (cantidadSeleccionada < 1) cantidadSeleccionada = 1;
                        if (cantidadSeleccionada > stockMaximo) cantidadSeleccionada = stockMaximo;
                    }

                    const itemCarrito = {
                        id: productoActual.idProducto,
                        nombre: productoActual.Nombre_Producto,
                        precio: Number(productoActual.Precio_Producto),
                        imagen: rutaImagen,
                        cantidad: cantidadSeleccionada
                    };

                    // Guardar en el LocalStorage
                    let carrito = JSON.parse(localStorage.getItem('lucimakeup_carrito')) || [];
                    const indexExistente = carrito.findIndex(item => Number(item.id) === Number(itemCarrito.id));
                    
                    if (indexExistente >= 0) {
                        carrito[indexExistente].cantidad += itemCarrito.cantidad;
                        if (carrito[indexExistente].cantidad > stockMaximo) {
                            carrito[indexExistente].cantidad = stockMaximo;
                        }
                    } else {
                        carrito.push(itemCarrito);
                    }

                    localStorage.setItem('lucimakeup_carrito', JSON.stringify(carrito));

                    // Redirigir a la vista del carrito
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