/**
 * Lógica para la creación de nueva contraseña - Lucimakeup Store
 */

document.addEventListener("DOMContentLoaded", () => {
    // Capturar parámetros de la URL (?token=xyz&email=usuario@correo.com)
    const urlParams = new URLSearchParams(window.location.search);
    const email = urlParams.get('email');
    const token = urlParams.get('token');

    const mensajeAlerta = document.getElementById('mensajeAlerta');
    const form = document.getElementById('formNuevaPassword');

    // Validar que el enlace contenga los parámetros necesarios
    if (!email || !token) {
        if (mensajeAlerta) {
            mensajeAlerta.innerHTML = "❌ Enlace inválido o expirado. Por favor solicita uno nuevo.";
            mensajeAlerta.className = "alerta error";
        }
        if (form) form.style.display = "none";
        return;
    }

    if (form) {
        form.addEventListener('submit', (e) => {
            e.preventDefault();
            
            const pass = document.getElementById('password').value.trim();
            const confirmPass = document.getElementById('confirmPassword').value.trim();

            // Validación de longitud
            if (pass.length < 6) {
                mostrarAlerta("⚠️ La contraseña debe tener al menos 6 caracteres.", "error");
                return;
            }

            // Validación de coincidencia
            if (pass !== confirmPass) {
                mostrarAlerta("❌ Las contraseñas no coinciden. Inténtalo de nuevo.", "error");
                return;
            }

            // Confirmación exitosa
            mostrarAlerta("✨ ¡Contraseña actualizada con éxito! Redirigiendo al inicio de sesión...", "exito");
            form.reset();

            // Redirección al login
            setTimeout(() => {
                window.location.href = 'login.html';
            }, 2500);
        });
    }
});

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