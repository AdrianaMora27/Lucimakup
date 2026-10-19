/**
 * Lógica avanzada y blindada de Confirmación de Pedido - Lucimakeup Store
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
    
    // Recuperar datos de envío o usar valores seguros por defecto
    const datosEnvioBrutos = JSON.parse(sessionStorage.getItem("lucimakeup_envio")) || {
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

    // Carrito de respaldo o recuperado sanitizado
    const carritoCrudo = JSON.parse(localStorage.getItem("lucimakeup_carrito")) || [
        { nombre: "Labial Matte Red", cantidad: 3, precioOriginal: 25000, precio: 25000 },
        { nombre: "Brillo Llavero", cantidad: 1, precioOriginal: 15000, precio: 15000 }
    ];

    if (listaProductos) {
        listaProductos.innerHTML = "";
        let subtotalBruto = 0;

        carritoCrudo.forEach(producto => {
            const precioUnit = Number(producto.precio || producto.precioOriginal) || 0;
            const cantidad = parseInt(producto.cantidad, 10) || 1;
            const subtotalItem = precioUnit * cantidad;
            subtotalBruto += subtotalItem;

            const li = document.createElement("li");
            li.innerHTML = `
                <span>${sanitizarTexto(producto.nombre || producto.Nombre_Producto)} (x${cantidad})</span>
                <span>$${subtotalItem.toLocaleString('es-CO')} COP</span>
            `;
            listaProductos.appendChild(li);
        });

        let costoEnvio = subtotalBruto >= 200000 || subtotalBruto === 0 ? 0 : 8000;
        let totalFinal = subtotalBruto + costoEnvio;

        if (totalConfirmacion) {
            totalConfirmacion.textContent = `$${totalFinal.toLocaleString('es-CO')} COP`;
        }
    }

    // Limpiar el carrito de compras principal de forma segura ya que la orden fue procesada
    localStorage.removeItem("lucimakeup_carrito");
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