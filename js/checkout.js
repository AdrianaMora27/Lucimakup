/**
 * Lógica del Checkout - Lucimakeup Store
 */

document.addEventListener("DOMContentLoaded", () => {
    cargarResumenCheckout();
    configurarBotonPagoDirecto();
});

function cargarResumenCheckout() {
    const listaResumen = document.getElementById("lista-resumen-checkout");
    const subtotalEl = document.getElementById("subtotal-checkout");
    const descuentoEl = document.getElementById("descuento-checkout");
    const envioEl = document.getElementById("envio-checkout");
    const totalCheckout = document.getElementById("total-checkout");
    
    const carrito = JSON.parse(localStorage.getItem("lucimakeup_carrito")) || [];

    if (listaResumen) {
        listaResumen.innerHTML = "";
        let subtotalBruto = 0;
        let descuentoTotal = 0;

        carrito.forEach(producto => {
            const precioUnitario = producto.precio || producto.precioOriginal;
            const descuentoUnitario = producto.descuento || 0;
            const subtotalItem = precioUnitario * producto.cantidad;
            const ahorroItem = descuentoUnitario * producto.cantidad;

            subtotalBruto += (precioUnitario + descuentoUnitario) * producto.cantidad;
            descuentoTotal += ahorroItem;

            const itemLi = document.createElement("li");
            itemLi.className = "resumen-orden__item";
            
            let textoDescuento = descuentoUnitario > 0 
                ? `<small style="color: #880e2f;">Ahorro: -$${ahorroItem.toLocaleString('es-CO')}</small>` 
                : `<small style="color: #666;">Sin descuento</small>`;

            itemLi.innerHTML = `
                <div style="display: flex; flex-direction: column;">
                    <span><strong>${producto.nombre || producto.Nombre_Producto}</strong> (x${producto.cantidad})</span>
                    <small style="color: #555;">Precio unitario: $${precioUnitario.toLocaleString('es-CO')}</small>
                    ${textoDescuento}
                </div>
                <strong style="text-align: right;">$${subtotalItem.toLocaleString('es-CO')}</strong>
            `;
            listaResumen.appendChild(itemLi);
        });

        let subtotalFinalVenta = subtotalBruto - descuentoTotal;
        let costoEnvio = subtotalFinalVenta >= 200000 || subtotalFinalVenta === 0 ? 0 : 8000;
        let totalFinal = subtotalFinalVenta + costoEnvio;

        if (subtotalEl) subtotalEl.textContent = `$${subtotalBruto.toLocaleString('es-CO')} COP`;
        if (descuentoEl) descuentoEl.textContent = `-$${descuentoTotal.toLocaleString('es-CO')} COP`;
        if (envioEl) envioEl.textContent = costoEnvio === 0 ? "¡Gratis!" : `$${costoEnvio.toLocaleString('es-CO')} COP`;
        if (totalCheckout) totalCheckout.textContent = `$${totalFinal.toLocaleString('es-CO')} COP`;
    }
}

function mostrarNotificacion(mensaje, tipo = 'error') {
    let contenedor = document.getElementById("toast-container");
    if (!contenedor) {
        contenedor = document.createElement("div");
        contenedor.id = "toast-container";
        contenedor.style.cssText = "position: fixed; top: 20px; right: 20px; z-index: 99999; display: flex; flex-direction: column; gap: 10px;";
        document.body.appendChild(contenedor);
    }

    const toast = document.createElement("div");
    const bgColor = tipo === 'success' ? '#2e7d32' : '#d32f2f';
    toast.style.cssText = `min-width: 280px; max-width: 380px; padding: 15px 20px; border-radius: 8px; color: #fff; font-family: inherit; font-size: 14px; background-color: ${bgColor}; box-shadow: 0 4px 12px rgba(0,0,0,0.2); display: flex; align-items: center; justify-content: space-between; opacity: 0; transform: translateY(-20px); transition: opacity 0.3s ease, transform 0.3s ease;`;
    toast.innerHTML = `<span>${mensaje}</span>`;

    contenedor.appendChild(toast);

    setTimeout(() => {
        toast.style.opacity = '1';
        toast.style.transform = 'translateY(0)';
    }, 10);

    setTimeout(() => {
        toast.style.opacity = '0';
        toast.style.transform = 'translateY(-20px)';
        setTimeout(() => toast.remove(), 300);
    }, 4000);
}

function configurarBotonPagoDirecto() {
    const btnPagar = document.getElementById("btn-confirmar-pago");

    if (!btnPagar) return;

    btnPagar.addEventListener("click", async (e) => {
        e.preventDefault();

        const inputNombre = document.getElementById("nombre");
        const inputEmail = document.getElementById("email");
        const inputDireccion = document.getElementById("direccion");
        const inputTelefono = document.getElementById("telefono");

        const nombre = inputNombre ? inputNombre.value.trim() : "";
        const email = inputEmail ? inputEmail.value.trim() : "";
        const direccion = inputDireccion ? inputDireccion.value.trim() : "";
        const telefono = inputTelefono ? inputTelefono.value.trim() : "";

        if (!nombre || !email || !direccion || !telefono) {
            mostrarNotificacion("⚠️ Por favor, completa todos los campos de envío.", "error");
            return;
        }

        const carrito = JSON.parse(localStorage.getItem("lucimakeup_carrito")) || [];
        if (carrito.length === 0) {
            mostrarNotificacion("⚠️ Tu carrito está vacío.", "error");
            return;
        }

        let subtotalProductos = carrito.reduce((acc, item) => acc + (Number(item.precio || item.precioOriginal) * Number(item.cantidad)), 0);
        let costoEnvio = subtotalProductos >= 200000 ? 0 : 8000;
        let totalFinal = subtotalProductos + costoEnvio;

        const usuarioLogueado = JSON.parse(localStorage.getItem("lucimakeup_usuario")) || null;
        const clienteId = usuarioLogueado ? usuarioLogueado.id : null;

        const datosPedido = {
            subtotal: subtotalProductos,
            costo_envio: costoEnvio,
            total: totalFinal,
            cliente_id: clienteId, 
            items: carrito
        };

        try {
            mostrarNotificacion("Procesando pedido y guardando en base de datos...", "success");

            const respuesta = await fetch('http://localhost:3000/api/pedido', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(datosPedido)
            });

            const resultado = await respuesta.json();

            if (respuesta.ok && resultado.exito) {
                const datosCliente = {
                    nombre: nombre,
                    email: email,
                    direccion: direccion,
                    telefono: telefono,
                    idPedido: resultado.idPedido
                };
                sessionStorage.setItem("lucimakeup_envio", JSON.stringify(datosCliente));

                mostrarNotificacion("¡Pedido registrado en la base de datos con éxito!", "success");
                
                setTimeout(() => {
                    localStorage.removeItem("lucimakeup_carrito");
                    window.location.href = "confirmacion.html";
                }, 1200);
            } else {
                mostrarNotificacion(`❌ Error: ${resultado.mensaje || 'No se pudo guardar el pedido.'}`, "error");
            }
        } catch (error) {
            console.error("Error de conexión con el servidor:", error);
            mostrarNotificacion("❌ Error de conexión con el servidor backend.", "error");
        }
    }); 
}