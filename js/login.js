document.addEventListener("DOMContentLoaded", () => {
    const formulario = document.querySelector("form");
    const inputCorreo = document.getElementById("correo");
    const inputPassword = document.getElementById("password");

    if (!formulario || !inputCorreo || !inputPassword) return;

    // Crear contenedor para notificaciones flotantes (toast)
    let notificacion = document.getElementById("notificacion-toast");
    if (!notificacion) {
        notificacion = document.createElement("div");
        notificacion.id = "notificacion-toast";
        notificacion.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            background-color: #4CAF50;
            color: white;
            padding: 1.5rem 2rem;
            border-radius: 0.8rem;
            font-size: 1.5rem;
            box-shadow: 0px 4px 12px rgba(0,0,0,0.2);
            z-index: 1000;
            display: none;
            font-family: Arial, sans-serif;
        `;
        document.body.appendChild(notificacion);
    }

    function mostrarNotificacion(mensaje, tipo = "exito") {
        notificacion.textContent = mensaje;
        notificacion.style.backgroundColor = tipo === "exito" ? "#4CAF50" : "#d32f2f";
        notificacion.style.display = "block";
        setTimeout(() => {
            notificacion.style.display = "none";
        }, 4000);
    }

    formulario.addEventListener("submit", (e) => {
        e.preventDefault();
        const correo = inputCorreo.value.trim();
        const password = inputPassword.value.trim();

        const regexCorreo = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        // Validar correo vacío
        if (!correo) {
            mostrarNotificacion("❌ Por favor, ingresa tu correo electrónico.", "error");
            inputCorreo.focus();
            inputCorreo.style.border = "2px solid #d32f2f";
            return;
        } else {
            inputCorreo.style.border = "";
        }

        // Validar formato de correo
        if (!regexCorreo.test(correo)) {
            mostrarNotificacion("❌ Correo electrónico inválido.", "error");
            inputCorreo.focus();
            inputCorreo.style.border = "2px solid #d32f2f";
            return;
        } else {
            inputCorreo.style.border = "";
        }

        // Validar contraseña vacía
        if (!password) {
            mostrarNotificacion("❌ Por favor, ingresa tu contraseña.", "error");
            inputPassword.focus();
            inputPassword.style.border = "2px solid #d32f2f";
            return;
        } else {
            inputPassword.style.border = "";
        }

        // Simulación de inicio de sesión exitoso
        mostrarNotificacion("✨ ¡Bienvenida de nuevo a Lucimakeup Store!", "exito");

        // Simular redirección a la tienda principal después de 2 segundos
        setTimeout(() => {
            window.location.href = "index.html";
        }, 2000);
    });
});