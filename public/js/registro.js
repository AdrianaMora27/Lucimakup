/**
 * Lógica de registro avanzada y blindada - Lucimakeup Store
 */

document.addEventListener("DOMContentLoaded", () => {
    const formRegistro = document.getElementById("form-registro");
    const inputNombre = document.getElementById("nombre");
    const inputTelefono = document.getElementById("telefono");
    const inputCorreo = document.getElementById("correo");
    const inputPassword = document.getElementById("password");

    // 🛡️ BLINDAJE EN TIEMPO REAL: Filtrar campos según su naturaleza
    if (inputTelefono) {
        inputTelefono.addEventListener("input", (e) => {
            // Solo permite números y limita a máximo 10 dígitos
            e.target.value = e.target.value.replace(/[^0-9]/g, "").slice(0, 10);
        });
    }

    if (inputNombre) {
        inputNombre.addEventListener("input", (e) => {
            // Solo permite letras, tildes y espacios, bloqueando símbolos o números
            e.target.value = e.target.value.replace(/[^a-zA-ZáéíóúÁÉÍÓÚñÑ\s]/g, "");
        });
    }

    if (inputCorreo) {
        inputCorreo.addEventListener("input", (e) => {
            // Remueve caracteres peligrosos para ataques XSS
            e.target.value = e.target.value.replace(/[<>"'`;()]/g, "").trim();
        });
    }

    if (formRegistro) {
        formRegistro.addEventListener("submit", async (e) => {
            e.preventDefault();

            // Capturar y sanitizar valores
            const nombre = sanitizarEntrada(inputNombre ? inputNombre.value.trim() : "");
            const telefono = inputTelefono ? inputTelefono.value.trim() : "";
            const correo = sanitizarEntrada(inputCorreo ? inputCorreo.value.trim() : "");
            const password = inputPassword ? inputPassword.value.trim() : "";

            // Validar campos vacíos
            if (!nombre || !telefono || !correo || !password) {
                mostrarNotificacion("⚠ Por favor, completa todos los campos del formulario.", "error");
                return;
            }

            // Validar teléfono colombiano (10 dígitos, empieza por 3)
            const regexCelular = /^3\d{9}$/;
            if (!regexCelular.test(telefono)) {
                mostrarNotificacion("❌ Celular inválido: debe tener 10 dígitos y empezar por 3.", "error");
                inputTelefono.focus();
                return;
            }

            // Validar correo con expresión regular estricta
            const regexCorreo = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (!regexCorreo.test(correo)) {
                mostrarNotificacion("❌ Correo electrónico inválido.", "error");
                inputCorreo.focus();
                return;
            }

            // Validar longitud y seguridad de contraseña
            if (password.length < 6 || password.length > 50) {
                mostrarNotificacion("⚠️ La contraseña debe tener entre 6 y 50 caracteres.", "error");
                inputPassword.focus();
                return;
            }

            try {
                // Petición segura al servidor Node.js mediante ruta relativa
                const respuesta = await fetch('/api/registro', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        nombre: nombre,
                        apellido: '',
                        telefono: telefono,
                        email: correo,
                        password: password
                    })
                });

                const resultado = await respuesta.json();

                if (respuesta.ok && resultado.exito) {
                    mostrarNotificacion("✨ ¡Cuenta creada y guardada en MySQL con éxito!", "success");
                    setTimeout(() => {
                        window.location.href = "login.html";
                    }, 2500);
                } else {
                    mostrarNotificacion(resultado.mensaje || "❌ Error al registrar en la base de datos.", "error");
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