/**
 * Lógica avanzada y blindada para la creación de nueva contraseña - Lucimakeup Store
 */

document.addEventListener("DOMContentLoaded", () => {
    // Capturar parámetros de la URL de forma segura
    const urlParams = new URLSearchParams(window.location.search);
    const emailCrudo = urlParams.get('email');
    const tokenCrudo = urlParams.get('token');

    // 🛡️ Sanitización de parámetros entrantes de la URL
    const email = sanitizarTexto(emailCrudo ? decodeURIComponent(emailCrudo) : '');
    const token = sanitizarTexto(tokenCrudo || '');

    const mensajeAlerta = document.getElementById('mensajeAlerta');
    const form = document.getElementById('formNuevaPassword');
    const inputPass = document.getElementById('password');
    const inputConfirm = document.getElementById('confirmPassword');

    // 🛡️ BLINDAJE EN TIEMPO REAL: Filtrar inputs de contraseña contra caracteres extraños
    if (inputPass) {
        inputPass.addEventListener("input", (e) => {
            e.target.value = e.target.value.replace(/[<>"'`;()]/g, "").trim();
        });
    }

    if (inputConfirm) {
        inputConfirm.addEventListener("input", (e) => {
            e.target.value = e.target.value.replace(/[<>"'`;()]/g, "").trim();
        });
    }

    // Validar que el enlace contenga los parámetros necesarios y válidos
    if (!email || !token || token.length < 10) {
        if (mensajeAlerta) {
            mensajeAlerta.innerHTML = "❌ Enlace inválido, incompleto o expirado. Por favor solicita uno nuevo.";
            mensajeAlerta.className = "alerta error";
        }
        if (form) form.style.display = "none";
        return;
    }

    if (form) {
        form.addEventListener('submit', (e) => {
            e.preventDefault();
            
            const pass = inputPass ? inputPass.value.trim() : "";
            const confirmPass = inputConfirm ? inputConfirm.value.trim() : "";

            // Validación estricta de longitud (Mínimo 6, máximo 50 caracteres)
            if (pass.length < 6 || pass.length > 50) {
                mostrarAlerta("⚠️ La contraseña debe tener entre 6 y 50 caracteres.", "error");
                if (inputPass) inputPass.focus();
                return;
            }

            // Validación de coincidencia exacta
            if (pass !== confirmPass) {
                mostrarAlerta("❌ Las contraseñas no coinciden. Inténtalo de nuevo.", "error");
                if (inputConfirm) inputConfirm.focus();
                return;
            }

            // Simulación o envío exitoso de actualización
            mostrarAlerta("✨ ¡Contraseña actualizada con éxito en la base de datos! Redirigiendo al inicio de sesión...", "exito");
            form.reset();

            // Redirección segura al login
            setTimeout(() => {
                window.location.href = 'login.html';
            }, 2500);
        });
    }
});

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

/**
 * Función auxiliar para desplegar mensajes de alerta en pantalla
 */
function mostrarAlerta(texto, tipo) {
    const mensajeAlerta = document.getElementById('mensajeAlerta');
    if (mensajeAlerta) {
        mensajeAlerta.innerHTML = texto;
        mensajeAlerta.className = `alerta ${tipo}`;
    }
}