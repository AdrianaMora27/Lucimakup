/**
 * Lógica para el detalle dinámico de productos - Lucimakeup Store
 */

document.addEventListener("DOMContentLoaded", () => {
    // 1. Obtener los parámetros de la URL (ej: productos.html?id=301)
    const parametrosURL = new URLSearchParams(window.location.search);
    const idProducto = parametrosURL.get("id");

    // 2. Si no hay ID en la URL, asignar uno por defecto (ej: 101) o usar el de la URL
    const idA_Buscar = idProducto ? Number(idProducto) : 101;

    // 3. Buscar el producto directamente en el arreglo global 'productos' (cargado desde productos.js)
    let productoActual = null;
    if (typeof productos !== 'undefined' && Array.isArray(productos)) {
        productoActual = productos.find(p => Number(p.idProducto) === idA_Buscar);
    }

    if (productoActual) {
        // 4. Actualizar los elementos del DOM dinámicamente con los nombres de campos exactos de tu BD
        const imagenEl = document.getElementById("imagen-producto");
        const nombreEl = document.getElementById("nombre-producto");
        const precioEl = document.getElementById("precio-producto");
        const descEl = document.getElementById("descripcion-producto");
        const inputIdHidden = document.getElementById("producto-id");

        if (imagenEl) {
            imagenEl.src = productoActual.imagen;
            imagenEl.alt = productoActual.Nombre_Producto;
        }
        if (nombreEl) nombreEl.textContent = productoActual.Nombre_Producto;
        if (precioEl) precioEl.textContent = `$${Number(productoActual.Precio_Producto).toLocaleString('es-CO')} COP`;
        if (descEl) descEl.textContent = productoActual.descripcion_producto;
        if (inputIdHidden) inputIdHidden.value = productoActual.idProducto;

        // Actualizar también el título de la pestaña del navegador
        document.title = `${productoActual.Nombre_Producto} - Lucimakeup Store`;

    } else {
        // Si el ID no existe en la base de datos
        const contenedorDetalle = document.getElementById("detalle-producto");
        if (contenedorDetalle) {
            contenedorDetalle.innerHTML = `
                <div style="grid-column: 1 / -1; text-align: center; padding: 4rem;">
                    <h2 style="color: #880e2f; font-size: 3rem;">⚠️ Producto no encontrado</h2>
                    <p style="font-size: 1.8rem; margin: 2rem 0;">Lo sentimos, el producto que buscas no existe o fue retirado del catálogo.</p>
                    <a href="index.html" class="boton" style="display: inline-block; width: auto; padding: 1rem 3rem; text-decoration: none;">Volver al Inicio</a>
                </div>
            `;
        }
    }
});