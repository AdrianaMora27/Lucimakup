/**
 * Lógica avanzada y blindada para recuperación de contraseña - Lucimakeup Store
 */

document.addEventListener("DOMContentLoaded", () => {
    const formulario = document.querySelector(".contenedor-recuperar form");
    const inputCorreo = document.getElementById("correo");

    // 🛡️ BLINDAJE EN TIEMPO REAL: Bloquea caracteres maliciosos (comillas, signos < >, scripts)
    if (inputCorreo) {
        inputCorreo.addEventListener("input", (e) => {
            // Elimina caracteres sospechosos e inyecciones comunes en tiempo real
            e.target.value = e.target.value.replace(/[<>"'`;()]/g, "").trim();
        });
    }

    if (formulario) {
        formulario.addEventListener("submit", (e) => {
            e.preventDefault();

            if (!inputCorreo) return;

            // Sanitización y limpieza de la entrada
            const correoLimpio = sanitizarEntrada(inputCorreo.value.trim());

            if (!correoLimpio) {
                mostrarNotificacion("⚠️ Por favor, ingresa tu correo electrónico.", "error");
                inputCorreo.focus();
                return;
            }

            // 🛡️ Validación de longitud (Prevención contra payloads masivos)
            if (correoLimpio.length > 50) {
                mostrarNotificacion("❌ El correo excede el tamaño máximo permitido (100 caracteres).", "error");
                inputCorreo.focus();
                return;
            }

            // 🛡️ Validación estricta con Expresión Regular para correo válido
            const regexCorreo = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (!regexCorreo.test(correoLimpio)) {
                mostrarNotificacion("❌ Correo electrónico inválido. Ingresa un formato correcto (ej: usuario@dominio.com).", "error");
                inputCorreo.focus();
                inputCorreo.style.border = "2px solid #d32f2f";
                return;
            } else {
                inputCorreo.style.border = "";
            }

            // Generar un token único simulado seguro
            const tokenSimulado = Math.random().toString(36).substring(2) + Date.now().toString(36);
            
            // CONSTRUCCIÓN DE LA URL COMPLETA CON EL ORIGEN DEL SERVIDOR LOCAL
            const enlaceRecuperacion = `${window.location.origin}/newpassword.html?token=${tokenSimulado}&email=${encodeURIComponent(correoLimpio)}`;

            // Simulación en consola con datos sanitizados
            console.log("--------------------------------------------------------------------------------");
            console.log(`📧 [BANDEJA DE ENTRADA SIMULADA - LUCIMAKEUP STORE]`);
            console.log(`Para: ${correoLimpio}`);
            console.log(`Asunto: 🔑 Restablece tu contraseña de Lucimakeup Store`);
            console.log(`Cuerpo: Hola. Has solicitado restablecer tu contraseña.`);
            console.log("👉 HAZ CLIC EN EL SIGUIENTE ENLACE PARA CREAR TU NUEVA CONTRASEÑA:");
            console.log(enlaceRecuperacion);
            console.log("--------------------------------------------------------------------------------");

            // Notificación exitosa
            mostrarNotificacion(`✨ ¡Correo enviado! Revisa tu bandeja de entrada en ${correoLimpio} para restablecer tu contraseña.`, "success");

            // Limpiar campo
            inputCorreo.value = "";
        });
    }
});

/**
 * 🛡️ Función auxiliar de Sanitización para prevenir ataques XSS
 */
function sanitizarEntrada(texto) {
    if (!texto) return "";
    return texto
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#x27;")
        .replace(/\//g, "&#x2F;");
}

/**
 * Sistema flotante de notificaciones estilo Toast
 */
function mostrarNotificacion(mensaje, tipo = "success") {
    let contenedor = document.getElementById("toast-container");
    if (!contenedor) {
        contenedor = document.createElement("div");
        contenedor.id = "toast-container";
        contenedor.style.position = "fixed";
        contenedor.style.top = "20px";
        contenedor.style.right = "20px";
        contenedor.style.zIndex = "1000";
        contenedor.style.display = "flex";
        contenedor.style.flexDirection = "column";
        contenedor.style.gap = "10px";
        document.body.appendChild(contenedor);
    }

    const toast = document.createElement("div");
    toast.className = `toast ${tipo}`;
    toast.textContent = mensaje;

    toast.style.minWidth = "300px";
    toast.style.maxWidth = "400px";
    toast.style.padding = "15px 20px";
    toast.style.borderRadius = "8px";
    toast.style.color = "#fff";
    toast.style.fontSize = "1.5rem";
    toast.style.boxShadow = "0 4px 12px rgba(0,0,0,0.2)";
    toast.style.backgroundColor = tipo === "success" ? "#2e7d32" : "#d32f2f";
    toast.style.borderLeft = tipo === "success" ? "6px solid #1b5e20" : "6px solid #880e2f";

    contenedor.appendChild(toast);

    setTimeout(() => {
        toast.style.opacity = "0";
        setTimeout(() => toast.remove(), 400);
    }, 5000);
}