/**
 * Lógica de Confirmación de Pedido - Lucimakeup Store
 */

document.addEventListener("DOMContentLoaded", () => {
    generarNumeroPedido();
    cargarDetallesConfirmacion();
    simularEnvioCorreo();
});

/**
 * Genera un número de pedido único aleatorio tipo #LUCI-XXXXX
 */
function generarNumeroPedido() {
    const elPedido = document.getElementById("numero-pedido");
    if (elPedido) {
        // Verificar si ya existe un número en sessionStorage para que no cambie si recarga la página
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
 * Carga el resumen de productos y los datos de envío guardados
 */
function cargarDetallesConfirmacion() {
    const listaProductos = document.getElementById("lista-productos-confirmacion");
    const totalConfirmacion = document.getElementById("total-confirmacion");
    
    // Recuperar datos de envío si se guardaron temporalmente, o usar valores por defecto
    const datosEnvio = JSON.parse(sessionStorage.getItem("lucimakeup_envio")) || {
        nombre: "Adriana",
        email: "adriana@gmail.com",
        direccion: "Calle 20 # 45, Cali",
        telefono: "3112224455"
    };

    // Actualizar campos de envío en pantalla
    document.getElementById("conf-nombre").textContent = datosEnvio.nombre;
    document.getElementById("conf-direccion").textContent = datosEnvio.direccion;
    document.getElementById("conf-telefono").textContent = datosEnvio.telefono;

    // Actualizar texto del correo electrónico en la alerta
    const alertaEmail = document.getElementById("mensaje-email-enviado");
    if (alertaEmail) {
        alertaEmail.innerHTML = `📧 Hemos enviado un correo electrónico de confirmación a <strong>${datosEnvio.email || 'tu correo'}</strong> con los detalles del pedido.`;
    }

    // Carrito de respaldo o recuperado
    const carrito = JSON.parse(localStorage.getItem("lucimakeup_carrito")) || [
        { nombre: "Labial Matte Red", cantidad: 3, precioOriginal: 25000, precio: 25000 },
        { nombre: "Brillo Llavero", cantidad: 1, precioOriginal: 15000, precio: 15000 }
    ];

    if (listaProductos) {
        listaProductos.innerHTML = "";
        let subtotalBruto = 0;

        carrito.forEach(producto => {
            const precioUnit = producto.precio || producto.precioOriginal;
            const subtotalItem = precioUnit * producto.cantidad;
            subtotalBruto += subtotalItem;

            const li = document.createElement("li");
            li.innerHTML = `
                <span>${producto.nombre} (x${producto.cantidad})</span>
                <span>$${subtotalItem.toLocaleString('es-CO')} COP</span>
            `;
            listaProductos.appendChild(li);
        });

        let costoEnvio = subtotalBruto >= 200000 ? 0 : 8000;
        let totalFinal = subtotalBruto + costoEnvio;

        if (totalConfirmacion) {
            totalConfirmacion.textContent = `$${totalFinal.toLocaleString('es-CO')} COP`;
        }
    }

    // Limpiar el carrito de compras principal ya que la orden fue procesada con éxito
    localStorage.removeItem("lucimakeup_carrito");
}

/**
 * Simula el proceso de envío de correo electrónico institucional
 */
function simularEnvioCorreo() {
    console.log("📨 [Sistema Mock Email]: Generando plantilla HTML de confirmación de pedido...");
    console.log("📨 [Sistema Mock Email]: Correo despachado exitosamente al cliente.");
}