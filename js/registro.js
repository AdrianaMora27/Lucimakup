/**
 * Lógica de registro - Lucimakeup Store
 */

document.addEventListener("DOMContentLoaded", () => {
    const formRegistro = document.getElementById("form-registro");

    if (formRegistro) {
        formRegistro.addEventListener("submit", async (e) => {
            e.preventDefault();

            // Capturar valores
            const nombre = document.getElementById("nombre").value.trim();
            const telefono = document.getElementById("telefono").value.trim();
            const correo = document.getElementById("correo").value.trim();
            const password = document.getElementById("password").value.trim();

            // Validar campos vacíos
            if (!nombre || !telefono || !correo || !password) {
                mostrarNotificacion("⚠️️ Por favor, completa todos los campos del formulario.", "error");
                return;
            }

            // Validar teléfono colombiano (10 dígitos, empieza por 3)
            const regexCelular = /^3\d{9}$/;
            if (!regexCelular.test(telefono)) {
                mostrarNotificacion("❌ Celular inválido: debe tener 10 dígitos y empezar por 3.", "error");
                document.getElementById("telefono").focus();
                return;
            }

            // Validar correo
            const regexCorreo = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!regexCorreo.test(correo)) {
                mostrarNotificacion("❌ Correo electrónico inválido.", "error");
                document.getElementById("correo").focus();
                return;
            }

            // Validar contraseña
            if (password.length < 6) {
                mostrarNotificacion("⚠️ La contraseña debe tener al menos 6 caracteres.", "error");
                document.getElementById("password").focus();
                return;
            }

            try {
                // Petición real al servidor Node.js
                const respuesta = await fetch('http://localhost:3000/api/registro', {
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

                if (resultado.exito) {
                    mostrarNotificacion("✨ ¡Cuenta creada y guardada en MySQL con éxito!", "success");
                    setTimeout(() => {
                        window.location.href = "login.html";
                    }, 2500);
                } else {
                    mostrarNotificacion(resultado.mensaje || "❌ Error al registrar en la base de datos.", "error");
                }

            } catch (error) {
                console.error("Error de conexión:", error);
                mostrarNotificacion("❌ No se pudo conectar con el servidor backend (puerto 3000).", "error");
            }
        });
    }
});

function mostrarNotificacion(mensaje, tipo = "success") {
    let contenedor = document.getElementById("toast-container");
    if (!contenedor) {
        contenedor = document.createElement("div");
        contenedor.id = "toast-container";
        document.body.appendChild(contenedor);
    }

    const toast = document.createElement("div");
    toast.className = `toast ${tipo}`;
    toast.textContent = mensaje;
    contenedor.appendChild(toast);

    setTimeout(() => {
        toast.style.opacity = "0";
        setTimeout(() => toast.remove(), 400);
    }, 3500);
}