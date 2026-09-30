/**
 * Lógica avanzada de registro y validación de correo - Lucimakeup Store
 */

document.addEventListener("DOMContentLoaded", () => {
    const formRegistro = document.getElementById("form-registro");

    if (formRegistro) {
        formRegistro.addEventListener("submit", (e) => {
            e.preventDefault(); // Evita el recargo de la página

            // Capturar valores
            const nombre = document.getElementById("nombre").value.trim();
            const telefono = document.getElementById("telefono").value.trim();
            const correo = document.getElementById("correo").value.trim();
            const password = document.getElementById("password").value.trim();

            // 1. Validar campos vacíos
            if (!nombre || !telefono || !correo || !password) {
                mostrarNotificacion("⚠️ Por favor, completa todos los campos del formulario.", "error");
                return;
            }

            // 2. Validar estructura de teléfono colombiano (debe empezar por 3 y tener 10 dígitos)
            const regexCelular = /^3\d{9}$/;
            if (!regexCelular.test(telefono)) {
                mostrarNotificacion("❌ Celular inválido: debe tener 10 dígitos y empezar por 3.", "error");
                document.getElementById("telefono").focus();
                return;
            }

            // 3. VALIDACIÓN ESTRICTA DE CORREO ELECTRÓNICO 📧
            const regexCorreo = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!regexCorreo.test(correo)) {
                mostrarNotificacion("❌ Correo electrónico inválido. Debe incluir '@' y un dominio (ej: tu@correo.com).", "error");
                document.getElementById("correo").focus();
                document.getElementById("correo").style.border = "2px solid #d32f2f";
                return;
            } else {
                document.getElementById("correo").style.border = "";
            }

            // 4. Validar longitud de contraseña
            if (password.length < 6) {
                mostrarNotificacion("⚠️ La contraseña debe tener al menos 6 caracteres.", "error");
                document.getElementById("password").focus();
                return;
            }

            // ==========================================
            // SIMULACIÓN DE ENVÍO DE CORREO DE BIENVENIDA
            // ==========================================
            console.log("----------------------------------------");
            console.log(`📧 [SISTEMA DE CORREO LUCIMAKEUP]:`);
            console.log(`Para: ${correo}`);
            console.log(`Asunto: ¡Bienvenida a Lucimakeup Store, ${nombre}! 💄`);
            console.log(`Cuerpo: Hola ${nombre}, tu cuenta ha sido creada exitosamente. Ya puedes iniciar sesión y disfrutar de nuestros productos.`);
            console.log("----------------------------------------");

            // 5. Éxito en el registro
            mostrarNotificacion(`✨ ¡Cuenta creada con éxito! Te hemos enviado un correo de bienvenida a ${correo}.`, "success");

            // Redirigir al login después de 2 segundos para que alcance a leer la notificación
            setTimeout(() => {
                window.location.href = "login.html";
            }, 2500);
        });
    }
});

/**
 * Sistema flotante de notificaciones estilo Toast
 */
function mostrarNotificacion(mensaje, tipo = "success") {
    // Buscar si ya existe el contenedor de toasts, si no, crearlo
    let contenedor = document.getElementById("toast-container");
    if (!contenedor) {
        contenedor = document.createElement("div");
        contenedor.id = "toast-container";
        document.body.appendChild(contenedor);
    }

    // Crear el elemento de notificación
    const toast = document.createElement("div");
    toast.className = `toast ${tipo}`;
    toast.textContent = mensaje;

    contenedor.appendChild(toast);

    // Eliminar la notificación después de 3.5 segundos
    setTimeout(() => {
        toast.style.opacity = "0";
        setTimeout(() => toast.remove(), 400);
    }, 3500);
}