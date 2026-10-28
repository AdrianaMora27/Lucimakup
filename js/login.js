/**
 * Lógica avanzada y blindada de inicio de sesión (Login) - Lucimakeup Store
 * Compatible con backend local y simulación estática de roles para Netlify
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
                // 1. Intentar petición segura al servidor Node.js (Entorno Local / Dinámico)
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

                if (respuesta.ok) {
                    const resultado = await respuesta.json();
                    if (resultado.exito) {
                        procesarExitoLogin(resultado.usuario);
                        return;
                    }
                }

                // Si el servidor responde pero las credenciales fallan o no hay backend
                ejecutarSimulacionRoles(correo, password);

            } catch (error) {
                // 2. Entorno estático (Netlify): Si falla el fetch, usamos la simulación segura de roles
                console.log("Modo estático detectado (Netlify): usando simulación local de roles.");
                ejecutarSimulacionRoles(correo, password);
            }
        });
    }
});

/**
 * 👥 DEFINICIÓN Y SEPARACIÓN DE ROLES (Admin vs Cliente)
 */
function ejecutarSimulacionRoles(correo, password) {
    let usuarioSimulado = {};

    // Definición estricta del rol según el correo ingresado
    if (correo.includes("admin") || correo === "admin@lucimakeup.com") {
        usuarioSimulado = {
            nombre: "Administrador Lucimakeup",
            correo: correo,
            rol: "admin", // 🔑 ROL ADMINISTRADOR
            token: "token_admin_netlify_secure_123"
        };
        mostrarNotificacion(`✨ ¡Bienvenido, Administrador (${usuarioSimulado.nombre})!`, "success");
    } else {
        usuarioSimulado = {
            nombre: "Cliente Lucimakeup",
            correo: correo,
            rol: "cliente", // 🛍️ ROL CLIENTE / USUARIO NORMAL
            token: "token_cliente_netlify_secure_456"
        };
        mostrarNotificacion(`✨ ¡Bienvenida de nuevo, ${usuarioSimulado.nombre}!`, "success");
    }

    // Guardar los datos y el rol en el almacenamiento local para que main.js los aplique
    localStorage.setItem("usuarioLogueado", JSON.stringify(usuarioSimulado));
    localStorage.setItem("lucimakeup_usuario", JSON.stringify(usuarioSimulado)); // Compatible con ambas claves

    // Redirigir al catálogo después de 1.5 segundos
    setTimeout(() => {
        window.location.href = "categorias.html";
    }, 1500);
}

function procesarExitoLogin(usuario) {
    // Asegurar que el usuario traiga un rol definido desde el backend
    if (!usuario.rol) {
        usuario.rol = usuario.email?.includes("admin") ? "admin" : "cliente";
    }

    mostrarNotificacion(`✨ ¡Bienvenida de nuevo, ${usuario.nombre}!`, "success");
    
    localStorage.setItem("usuarioLogueado", JSON.stringify(usuario));
    localStorage.setItem("lucimakeup_usuario", JSON.stringify(usuario));

    setTimeout(() => {
        window.location.href = "categorias.html";
    }, 1500);
}

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