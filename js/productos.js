/**
 * Lógica general del catálogo, renderizado dinámico y filtros de búsqueda - Lucimakeup Store
 * Conectado al backend local (Node.js / MySQL)
 */

document.addEventListener('DOMContentLoaded', () => {
    // Cargar los productos al iniciar la página si existe algún contenedor de catálogo o rejilla
    cargarProductosCatalogo();
});

/**
 * Función para consultar y renderizar los productos desde la API de MySQL
 */
async function cargarProductosCatalogo() {
    try {
        const respuesta = await fetch('/api/productos');
        if (!respuesta.ok) {
            throw new Error('Error al obtener los productos del servidor.');
        }

        const productos = await respuesta.json();
        
        // Opcional: Si tienes una función global para mostrar tarjetas en el catálogo general
        if (typeof mostrarProductosEnVista === 'function') {
            mostrarProductosEnVista(productos);
        }

    } catch (error) {
        console.error("Error de red al conectar con la API de productos:", error);
    }
}

/**
 * 🔍 Lógica blindada para el filtro de búsqueda en tiempo real desde la cabecera
 */
async function filtrarProductos() {
    const inputBuscador = document.getElementById('inputBuscador');
    if (!inputBuscador) return;

    const terminoBusqueda = inputBuscador.value.trim();

    try {
        const respuesta = await fetch(`/api/productos?buscar=${encodeURIComponent(terminoBusqueda)}`);
        if (!respuesta.ok) throw new Error('Error en la búsqueda');

        const resultados = await respuesta.json();
        
        // Si estás actualizando la vista de forma dinámica por JS:
        actualizarVistaConResultados(resultados);

    } catch (error) {
        console.error("Error al filtrar los productos:", error);
    }
}

/**
 * Actualiza los elementos visuales en las vistas de categorías / catálogo según la búsqueda
 */
function actualizarVistaConResultados(productos) {
    // Si tus vistas usan tarjetas fijas en HTML (como cuidadoPersonal.html y maquillaje.html),
    // este bloque oculta o muestra las tarjetas según coincidan con el ID o nombre devuelto por MySQL.
    const tarjetas = document.querySelectorAll('.tarjeta-producto');
    
    if (!tarjetas || tarjetas.length === 0) return;

    const idsValidos = productos.map(p => Number(p.idProducto));

    tarjetas.index = 0;
    tarjetas.forEach(tarjeta => {
        const idTarjeta = Number(tarjeta.getAttribute('data-id'));
        if (idsValidos.includes(idTarjeta)) {
            tarjeta.style.display = 'flex';
        } else {
            tarjeta.style.display = 'none';
        }
    });
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