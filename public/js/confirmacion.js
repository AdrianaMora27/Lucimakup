/**
 * Lógica avanzada, blindada y sanitizada de Confirmación de Pedido - Lucimakeup Store
 */

document.addEventListener("DOMContentLoaded", () => {
    generarNumeroPedido();
    cargarDetallesConfirmacion();
    simularEnvioCorreo();
});

/**
 * Genera un número de pedido único aleatorio tipo #LUCI-XXXXX de forma segura
 */
function generarNumeroPedido() {
    const elPedido = document.getElementById("numero-pedido");
    if (elPedido) {
        let numPedido = sessionStorage.getItem("lucimakeup_num_pedido");
        if (!numPedido) {
            const aleatorio = Math.floor(10000 + Math.random() * 90000);
            numPedido = `#LUCI-${aleatorio}`;
            sessionStorage.setItem("lucimakeup_num_pedido", numPedido);
        }
        elPedido.textContent = numPedido;
    }
}

/**
 * Carga el resumen de productos y los datos de envío sanitizados de forma segura
 */
function cargarDetallesConfirmacion() {
    const listaProductos = document.getElementById("lista-productos-confirmacion");
    const totalConfirmacion = document.getElementById("total-confirmacion");
    
    // Recuperar datos de envío o usar valores por defecto seguros
    const datosEnvioBrutos = JSON.parse(sessionStorage.getItem("lucimakeup_envio")) || 
                             JSON.parse(localStorage.getItem("lucimakeup_envio")) || {
        nombre: "Cliente",
        email: "cliente@correo.com",
        direccion: "Dirección principal",
        telefono: "3000000000"
    };

    // 🛡️ Sanitizar todos los datos de envío recuperados
    const datosEnvio = {
        nombre: sanitizarTexto(datosEnvioBrutos.nombre),
        email: sanitizarTexto(datosEnvioBrutos.email),
        direccion: sanitizarTexto(datosEnvioBrutos.direccion),
        telefono: sanitizarTexto(datosEnvioBrutos.telefono)
    };

    // Actualizar campos de envío en pantalla de forma segura
    const confNombre = document.getElementById("conf-nombre");
    const confDireccion = document.getElementById("conf-direccion");
    const confTelefono = document.getElementById("conf-telefono");

    if (confNombre) confNombre.textContent = datosEnvio.nombre;
    if (confDireccion) confDireccion.textContent = datosEnvio.direccion;
    if (confTelefono) confTelefono.textContent = datosEnvio.telefono;

    // Actualizar texto del correo electrónico en la alerta
    const alertaEmail = document.getElementById("mensaje-email-enviado");
    if (alertaEmail) {
        alertaEmail.innerHTML = `📧 Hemos enviado un correo electrónico de confirmación a <strong>${datosEnvio.email || 'tu correo'}</strong> con los detalles del pedido.`;
    }

    // 🔄 Buscar el carrito priorizando el último respaldo de sesión y luego localStorage
    let carritoCrudo = JSON.parse(sessionStorage.getItem("lucimakeup_carrito_ultimo")) || 
                       JSON.parse(localStorage.getItem("lucimakeup_carrito")) || 
                       JSON.parse(localStorage.getItem("carrito"));

    // Si aún no encuentra carrito, intentar buscar si se seleccionó un producto único
    if (!carritoCrudo || !Array.isArray(carritoCrudo) || carritoCrudo.length === 0) {
        const itemUnico = JSON.parse(sessionStorage.getItem("lucimakeup_producto_seleccionado"));
        if (itemUnico) {
            carritoCrudo = [itemUnico];
        } else {
            carritoCrudo = [];
        }
    }

    if (listaProductos) {
        listaProductos.innerHTML = "";
        let subtotalBruto = 0;

        if (carritoCrudo.length === 0) {
            listaProductos.innerHTML = "<li><span>No se encontraron productos en el pedido</span></li>";
        } else {
            carritoCrudo.forEach(producto => {
                const nombreProd = producto.nombre || producto.Nombre_Producto || producto.titulo || producto.title || "Producto";
                const precioUnit = Number(producto.precio || producto.precioOriginal || producto.price) || 0;
                const cantidad = parseInt(producto.cantidad, 10) || 1;
                const subtotalItem = precioUnit * cantidad;
                subtotalBruto += subtotalItem;

                const li = document.createElement("li");
                li.innerHTML = `
                    <span>${sanitizarTexto(nombreProd)} (x${cantidad})</span>
                    <span>$${subtotalItem.toLocaleString('es-CO')} COP</span>
                `;
                listaProductos.appendChild(li);
            });
        }

        let costoEnvio = (subtotalBruto >= 200000 || subtotalBruto === 0) ? 0 : 8000;
        let totalFinal = subtotalBruto + costoEnvio;

        if (totalConfirmacion) {
            totalConfirmacion.textContent = `$${totalFinal.toLocaleString('es-CO')} COP`;
        }
    }

    // Guardar copia de respaldo en sessionStorage para que no se pierda al recargar la página
    if (carritoCrudo.length > 0) {
        sessionStorage.setItem("lucimakeup_carrito_ultimo", JSON.stringify(carritoCrudo));
    }

    // Limpiar los carritos del almacenamiento local una vez procesados
    localStorage.removeItem("lucimakeup_carrito");
    localStorage.removeItem("carrito");
}

/**
 * Simula el proceso de envío de correo electrónico institucional de manera segura
 */
function simularEnvioCorreo() {
    console.log("📨 [Sistema Mock Email]: Generando plantilla HTML de confirmación de pedido...");
    console.log("📨 [Sistema Mock Email]: Correo despachado exitosamente al cliente.");
}

/**
 * 🛡️ Función auxiliar de Sanitización para prevenir ataques XSS
 */
function sanitizarTexto(texto) {
    if (!texto) return "";
    return String(texto)
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#x27;")
        .replace(/\//g, "&#x2F;");
}