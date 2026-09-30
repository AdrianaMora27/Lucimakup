/**
 * Lógica del Checkout - Lucimakeup Store
 * Versión ultra-robuesta con escucha directa en el botón de pago
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
    
    const carrito = JSON.parse(localStorage.getItem("lucimakeup_carrito")) || [
        { nombre: "Labial Matte Red", cantidad: 3, precioOriginal: 25000, precio: 25000, descuento: 0 },
        { nombre: "Brillo Llavero", cantidad: 1, precioOriginal: 15000, precio: 15000, descuento: 0 }
    ];

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
                ? `<small style="color: #880e2f;">Ahorro: -$${ahorroItem.toLocaleString('es-CO')} (-$${descuentoUnitario.toLocaleString('es-CO')} c/u)</small>` 
                : `<small style="color: #666;">Sin descuento</small>`;

            itemLi.innerHTML = `
                <div style="display: flex; flex-direction: column;">
                    <span><strong>${producto.nombre}</strong> (x${producto.cantidad})</span>
                    <small style="color: #555;">Precio unitario: $${(precioUnitario + descuentoUnitario).toLocaleString('es-CO')}</small>
                    ${textoDescuento}
                </div>
                <strong style="text-align: right;">$${subtotalItem.toLocaleString('es-CO')}</strong>
            `;
            listaResumen.appendChild(itemLi);
        });

        let subtotalFinalVenta = subtotalBruto - descuentoTotal;
        let costoEnvio = subtotalFinalVenta >= 200000 ? 0 : 8000;
        let totalFinal = subtotalFinalVenta + costoEnvio;

        if (subtotalEl) subtotalEl.textContent = `$${subtotalBruto.toLocaleString('es-CO')} COP`;
        if (descuentoEl) descuentoEl.textContent = `-$${descuentoTotal.toLocaleString('es-CO')} COP`;
        if (envioEl) envioEl.textContent = costoEnvio === 0 ? "¡Gratis!" : `$${costoEnvio.toLocaleString('es-CO')} COP`;
        if (totalCheckout) totalCheckout.textContent = `$${totalFinal.toLocaleString('es-CO')} COP`;
    }
}

/**
 * Muestra una notificación flotante visual (Toast)
 */
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

    // Forzar reflow para activar transición
    setTimeout(() => {
        toast.style.opacity = '1';
        toast.style.transform = 'translateY(0)';
    }, 10);

    // Desaparecer a los 4 segundos
    setTimeout(() => {
        toast.style.opacity = '0';
        toast.style.transform = 'translateY(-20px)';
        setTimeout(() => toast.remove(), 300);
    }, 4000);
}

function configurarBotonPagoDirecto() {
    // Buscamos directamente el botón por su ID que se ve en tu HTML
    const btnPagar = document.getElementById("btn-confirmar-pago");

    if (!btnPagar) {
        console.error("No se encontró el botón con ID 'btn-confirmar-pago'");
        return;
    }

    btnPagar.addEventListener("click", (e) => {
        // Prevenimos cualquier comportamiento por defecto del botón
        e.preventDefault();

        const inputNombre = document.getElementById("nombre");
        const inputEmail = document.getElementById("email");
        const inputDireccion = document.getElementById("direccion");
        const inputTelefono = document.getElementById("telefono");

        const nombre = inputNombre ? inputNombre.value.trim() : "";
        const email = inputEmail ? inputEmail.value.trim() : "";
        const direccion = inputDireccion ? inputDireccion.value.trim() : "";
        const telefono = inputTelefono ? inputTelefono.value.trim() : "";

        // 1. Validar campos vacíos
        if (!nombre || !email || !direccion || !telefono) {
            mostrarNotificacion("⚠️ Por favor, completa todos los campos de envío.", "error");
            return;
        }

        // 2. VALIDACIÓN ESTRICTA DE CORREO
        const regexEmail = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (!regexEmail.test(email)) {
            mostrarNotificacion("❌ Correo incompleto (Ej: usuario@gmail.com)", "error");
            if (inputEmail) {
                inputEmail.focus();
                inputEmail.style.border = "2px solid #d32f2f";
            }
            return;
        } else {
            if (inputEmail) inputEmail.style.border = "";
        }

        // 3. VALIDACIÓN ESTRICTA DE TELÉFONO
        const regexCelular = /^3\d{9}$/;
        if (!regexCelular.test(telefono)) {
            mostrarNotificacion("❌ Celular inválido: 10 dígitos y empezar por 3", "error");
            if (inputTelefono) {
                inputTelefono.focus();
                inputTelefono.style.border = "2px solid #d32f2f";
            }
            return;
        } else {
            if (inputTelefono) inputTelefono.style.border = "";
        }

      // 4. ÉXITO: Guardar datos y redirigir
        const datosCliente = {
            nombre: inputNombre.value.trim(),
            email: inputEmail.value.trim(),
            direccion: inputDireccion.value.trim(),
            telefono: inputTelefono.value.trim()
        };
        sessionStorage.setItem("lucimakeup_envio", JSON.stringify(datosCliente));

        mostrarNotificacion("¡Datos correctos! Redirigiendo...", "success");
        
        setTimeout(() => {
            localStorage.removeItem("lucimakeup_carrito");
            window.location.href = "confirmacion.html";
        }, 1000);
    }); // Cierre del addEventListener del botón
}     // Cierre de la función configurarBotonPagoDirecto