/**
 * Lógica del Checkout Avanzada y Blindada - Lucimakeup Store
 */

document.addEventListener("DOMContentLoaded", () => {
    cargarResumenCheckout();
    configurarBotonPagoDirecto();
    configurarCodigoPromocional();
    configurarFiltrosEntradaCheckout(); // 🛡️ Filtros de tiempo real activados
});

let descuentoAplicadoMonto = 0; // Variable global para rastrear el descuento del cupón

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
        let descuentoTotalProductos = 0;

        carrito.forEach(producto => {
            const precioUnitario = Number(producto.precio || producto.precioOriginal) || 0;
            const descuentoUnitario = Number(producto.descuento) || 0;
            const cantidad = parseInt(producto.cantidad, 10) || 1;
            
            const subtotalItem = precioUnitario * cantidad;
            const ahorroItem = descuentoUnitario * cantidad;

            subtotalBruto += (precioUnitario + descuentoUnitario) * cantidad;
            descuentoTotalProductos += ahorroItem;

            const itemLi = document.createElement("li");
            itemLi.className = "resumen-orden__item";
            
            let textoDescuento = descuentoUnitario > 0 
                ? `<small style="color: #880e2f;">Ahorro: -$${ahorroItem.toLocaleString('es-CO')}</small>` 
                : `<small style="color: #666;">Sin descuento</small>`;

            // 🛡️ Sanitizar nombres del producto antes de inyectar en HTML
            const nombreLimpio = sanitizarTexto(producto.nombre || producto.Nombre_Producto);

            itemLi.innerHTML = `
                <div style="display: flex; flex-direction: column;">
                    <span><strong>${nombreLimpio}</strong> (x${cantidad})</span>
                    <small style="color: #555;">Precio unitario: $${precioUnitario.toLocaleString('es-CO')}</small>
                    ${textoDescuento}
                </div>
                <strong style="text-align: right;">$${subtotalItem.toLocaleString('es-CO')}</strong>
            `;
            listaResumen.appendChild(itemLi);
        });

        let subtotalFinalVenta = subtotalBruto - descuentoTotalProductos - descuentoAplicadoMonto;
        if (subtotalFinalVenta < 0) subtotalFinalVenta = 0;

        let costoEnvio = subtotalFinalVenta >= 200000 || subtotalFinalVenta === 0 ? 0 : 8000;
        let totalFinal = subtotalFinalVenta + costoEnvio;

        let descuentoTotalGeneral = descuentoTotalProductos + descuentoAplicadoMonto;

        if (subtotalEl) subtotalEl.textContent = `$${subtotalBruto.toLocaleString('es-CO')} COP`;
        if (descuentoEl) descuentoEl.textContent = `-$${descuentoTotalGeneral.toLocaleString('es-CO')} COP`;
        if (envioEl) envioEl.textContent = costoEnvio === 0 ? "¡Gratis!" : `$${costoEnvio.toLocaleString('es-CO')} COP`;
        if (totalCheckout) totalCheckout.textContent = `$${totalFinal.toLocaleString('es-CO')} COP`;
    }
}

function configurarCodigoPromocional() {
    const btnAplicar = document.getElementById("btn-aplicar-cupon"); 
    const inputCupon = document.getElementById("input-cupon");

    if (!btnAplicar || !inputCupon) return;

    btnAplicar.addEventListener("click", (e) => {
        e.preventDefault();
        const codigo = sanitizarTexto(inputCupon.value.trim().toUpperCase());

        const cuponesValidos = {
            'LUCILOVER': 0.15,    // 15% de descuento
            'LUCIMAKEUP10': 0.10, // 10% de descuento
            'DESCUENTO5000': 5000 // $5.000 COP fijos
        };

        if (cuponesValidos[codigo] !== undefined) {
            const carrito = JSON.parse(localStorage.getItem("lucimakeup_carrito")) || [];
            let subtotalBruto = carrito.reduce((acc, item) => acc + ((Number(item.precio || item.precioOriginal) + Number(item.descuento || 0)) * Number(item.cantidad)), 0);
            
            if (codigo === 'DESCUENTO5000') {
                descuentoAplicadoMonto = 5000;
            } else {
                descuentoAplicadoMonto = subtotalBruto * cuponesValidos[codigo];
            }

            mostrarNotificacion(`¡Cupón "${codigo}" aplicado con éxito!`, "success");
            cargarResumenCheckout();
        } else {
            mostrarNotificacion("❌ Código promocional inválido o expirado.", "error");
        }
    });
}

/**
 * 🛡️ Filtros en tiempo real para bloquear caracteres extraños o maliciosos en el Frontend
 */
function configurarFiltrosEntradaCheckout() {
    const inputTelefono = document.getElementById("telefono");
    const inputNombre = document.getElementById("nombre");
    const inputEmail = document.getElementById("email");
    const inputDireccion = document.getElementById("direccion");

    if (inputTelefono) {
        // Solo permite números, máximo 10 dígitos
        inputTelefono.addEventListener("input", (e) => {
            e.target.value = e.target.value.replace(/[^0-9]/g, "").slice(0, 10);
        });
    }

    if (inputNombre) {
        // Solo permite letras y espacios, bloqueando símbolos o números
        inputNombre.addEventListener("input", (e) => {
            e.target.value = e.target.value.replace(/[^a-zA-ZáéíóúÁÉÍÓÚñÑ\s]/g, "");
        });
    }

    if (inputEmail) {
        inputEmail.addEventListener("input", (e) => {
            e.target.value = e.target.value.replace(/[<>"'`;()]/g, "").trim();
        });
    }

    if (inputDireccion) {
        inputDireccion.addEventListener("input", (e) => {
            e.target.value = e.target.value.replace(/[<>"'`;()]/g, "");
        });
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
    toast.innerHTML = `<span>${sanitizarTexto(mensaje)}</span>`;

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

        // Sanitización previa
        const nombre = sanitizarTexto(inputNombre ? inputNombre.value.trim() : "");
        const email = sanitizarTexto(inputEmail ? inputEmail.value.trim() : "");
        const direccion = sanitizarTexto(inputDireccion ? inputDireccion.value.trim() : "");
        const telefono = inputTelefono ? inputTelefono.value.trim() : "";

        if (!nombre || !email || !direccion || !telefono) {
            mostrarNotificacion("⚠️ Por favor, completa todos los campos de envío.", "error");
            return;
        }

        // 🛡️ Validación estricta con expresión regular
        const regexEmail = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (!regexEmail.test(email)) {
            mostrarNotificacion("❌ El formato del correo electrónico no es válido.", "error");
            if (inputEmail) inputEmail.focus();
            return;
        }

        if (telefono.length < 7) {
            mostrarNotificacion("❌ El número de teléfono debe tener al menos 7 dígitos.", "error");
            if (inputTelefono) inputTelefono.focus();
            return;
        }

        const carrito = JSON.parse(localStorage.getItem("lucimakeup_carrito")) || [];
        if (carrito.length === 0) {
            mostrarNotificacion("⚠️ Tu carrito está vacío.", "error");
            return;
        }

        let subtotalBruto = carrito.reduce((acc, item) => acc + ((Number(item.precio || item.precioOriginal) + Number(item.descuento || 0)) * Number(item.cantidad)), 0);
        let descuentoTotalProductos = carrito.reduce((acc, item) => acc + (Number(item.descuento || 0) * Number(item.cantidad)), 0);
        
        let subtotalFinalVenta = subtotalBruto - descuentoTotalProductos - descuentoAplicadoMonto;
        if (subtotalFinalVenta < 0) subtotalFinalVenta = 0;

        let costoEnvio = subtotalFinalVenta >= 200000 || subtotalFinalVenta === 0 ? 0 : 8000;
        let totalFinal = subtotalFinalVenta + costoEnvio;

        const usuarioLogueado = JSON.parse(localStorage.getItem("lucimakeup_usuario")) || null;
        const clienteId = usuarioLogueado ? usuarioLogueado.id : null;

        const datosPedido = {
            subtotal: subtotalFinalVenta,
            costo_envio: costoEnvio,
            total: totalFinal,
            cliente_id: clienteId, 
            items: carrito
        };

        try {
            mostrarNotificacion("Procesando pedido y guardando en base de datos...", "success");

            const respuesta = await fetch('/api/pedido', {
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