/**
 * Lógica avanzada y blindada de inicio de sesión (Login) - Lucimakeup Store
 */

document.addEventListener("DOMContentLoaded", () => {
    const formLogin = document.getElementById("form-login");
    const inputCorreo = document.getElementById("correo");
    const inputPassword = document.getElementById("password");

    // 🛡️ BLINDAJE EN TIEMPO REAL: Filtrar el campo de correo contra caracteres sospechosos
    if (inputCorreo) {
        inputCorreo.addEventListener("input", (e) => {
            e.target.value = e.target.value.replace(/[<>"'`;()]/g, "").trim();
        });
    }

    if (formLogin) {
        formLogin.addEventListener("submit", async (e) => {
            e.preventDefault();

            // Capturar y sanitizar valores
            const correo = sanitizarTexto(inputCorreo ? inputCorreo.value.trim() : "");
            const password = inputPassword ? inputPassword.value.trim() : "";

            // Validar campos vacíos
            if (!correo || !password) {
                mostrarNotificacion("⚠ Por favor, ingresa tu correo y contraseña.", "error");
                return;
            }

            // Validar formato estricto de correo
            const regexCorreo = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (!regexCorreo.test(correo)) {
                mostrarNotificacion("❌ Ingresa un correo electrónico válido.", "error");
                if (inputCorreo) inputCorreo.focus();
                return;
            }

            // Validar longitud de contraseña
            if (password.length < 6 || password.length > 50) {
                mostrarNotificacion("⚠️ La contraseña debe tener entre 6 y 50 caracteres.", "error");
                if (inputPassword) inputPassword.focus();
                return;
            }

            try {
                // Petición segura al servidor Node.js mediante ruta relativa
                const respuesta = await fetch('/api/login', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        email: correo,
                        password: password
                    })
                });

                const resultado = await respuesta.json();

                if (respuesta.ok && resultado.exito) {
                    mostrarNotificacion(`✨ ¡Bienvenida de nuevo, ${resultado.usuario.nombre}!`, "success");
                    
                    // Guardar los datos del usuario en el almacenamiento local de forma segura
                    localStorage.setItem("usuarioLogueado", JSON.stringify(resultado.usuario));

                    // Redirigir al index de la tienda después de 2 segundos
                    setTimeout(() => {
                        window.location.href = "index.html";
                    }, 2000);
                } else {
                    mostrarNotificacion(resultado.mensaje || "❌ Correo o contraseña incorrectos.", "error");
                }

            } catch (error) {
                console.error("Error de conexión:", error);
                mostrarNotificacion("❌ No se pudo conectar con el servidor backend.", "error");
            }
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

function mostrarNotificacion(mensaje, tipo = "success") {
    let contenedor = document.getElementById("toast-container");
    if (!contenedor) {
        contenedor = document.createElement("div");
        contenedor.id = "toast-container";
        contenedor.style.position = "fixed";
        contenedor.style.top = "20px";
        contenedor.style.right = "20px";
        contenedor.style.zIndex = "99999";
        contenedor.style.display = "flex";
        contenedor.style.flexDirection = "column";
        contenedor.style.gap = "10px";
        document.body.appendChild(contenedor);
    }

    const toast = document.createElement("div");
    toast.className = `toast ${tipo}`;
    toast.textContent = mensaje;

    toast.style.minWidth = "280px";
    toast.style.maxWidth = "380px";
    toast.style.padding = "15px 20px";
    toast.style.borderRadius = "8px";
    toast.style.color = "#fff";
    toast.style.fontSize = "1.4rem";
    toast.style.boxShadow = "0 4px 12px rgba(0,0,0,0.2)";
    toast.style.backgroundColor = tipo === "success" ? "#2e7d32" : "#d32f2f";
    toast.style.borderLeft = tipo === "success" ? "6px solid #1b5e20" : "6px solid #880e2f";

    contenedor.appendChild(toast);

    setTimeout(() => {
        toast.style.opacity = "0";
        setTimeout(() => toast.remove(), 400);
    }, 3500);
}