/**
 * Lógica avanzada para recuperación de contraseña - Lucimakeup Store
 */

document.addEventListener("DOMContentLoaded", () => {
    const formulario = document.querySelector(".contenedor-recuperar form");

    if (formulario) {
        formulario.addEventListener("submit", (e) => {
            e.preventDefault();

            const inputCorreo = document.getElementById("correo");
            const correo = inputCorreo.value.trim();

            if (!correo) {
                mostrarNotificacion("⚠️ Por favor, ingresa tu correo electrónico.", "error");
                inputCorreo.focus();
                return;
            }

            // Validación estricta de correo
            const regexCorreo = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!regexCorreo.test(correo)) {
                mostrarNotificacion("❌ Correo electrónico inválido. Debe incluir '@' y un dominio (ej: tu@correo.com).", "error");
                inputCorreo.focus();
                inputCorreo.style.border = "2px solid #d32f2f";
                return;
            } else {
                inputCorreo.style.border = "";
            }

            // Generar un token único simulado para el enlace de recuperación
            const tokenSimulado = Math.random().toString(36).substring(2) + Date.now().toString(36);
            const enlaceRecuperacion = `newpassword.html?token=${tokenSimulado}&email=${encodeURIComponent(correo)}`;

            // Simulación realista del correo enviado en la consola del navegador
            console.log("--------------------------------------------------------------------------------");
            console.log(`📧 [BANDEJA DE ENTRADA SIMULADA - LUCIMAKEUP STORE]`);
            console.log(`Para: ${correo}`);
            console.log(`Asunto: 🔑 Restablece tu contraseña de Lucimakeup Store`);
            console.log(`Cuerpo: Hola. Has solicitado restablecer tu contraseña.`);
            console.log("👉 HAZ CLIC EN EL SIGUIENTE ENLACE PARA CREAR TU NUEVA CONTRASEÑA:");
            console.log(enlaceRecuperacion);
            console.log("--------------------------------------------------------------------------------");

            // Mostrar mensaje claro en pantalla como lo pediste
            mostrarNotificacion(`✨ ¡Correo enviado! Revisa tu bandeja de entrada en ${correo} para restablecer tu contraseña.`, "success");

            // Limpiar campo
            inputCorreo.value = "";

            // Opcional: Podríamos abrir automáticamente una simulación del enlace o dejar que la usuaria 
            // vea la consola. Aquí la redirigiremos a una página de aviso o le daremos un momento 
            // para que note el enlace en la consola.
        });
    }
});

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
    }, 5000); // 5 segundos para que alcance a leer bien el mensaje largo
}