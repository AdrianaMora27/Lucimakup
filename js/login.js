/**
 * Lógica de inicio de sesión (Login) - Lucimakeup Store
 */

document.addEventListener("DOMContentLoaded", () => {
    const formLogin = document.getElementById("form-login");

    if (formLogin) {
        formLogin.addEventListener("submit", async (e) => {
            e.preventDefault();

            // Capturar valores
            const correo = document.getElementById("correo").value.trim();
            const password = document.getElementById("password").value.trim();

            // Validar campos vacíos
            if (!correo || !password) {
                mostrarNotificacion("⚠ Por favor, ingresa tu correo y contraseña.", "error");
                return;
            }

            // Validar formato de correo
            const regexCorreo = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!regexCorreo.test(correo)) {
                mostrarNotificacion("❌ Ingresa un correo electrónico válido.", "error");
                document.getElementById("correo").focus();
                return;
            }

            try {
                // Petición real al servidor Node.js (server.js)
                const respuesta = await fetch('http://localhost:3000/api/login', {
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

                if (resultado.exito) {
                    mostrarNotificacion(`✨ ¡Bienvenida de nuevo, ${resultado.usuario.nombre}!`, "success");
                    
                    // Guardar los datos del usuario en el almacenamiento local si lo necesitas en la tienda
                    localStorage.setItem("usuarioLogueado", JSON.stringify(resultado.usuario));

                    // Redirigir al catálogo o index de la tienda después de 2 segundos
                    setTimeout(() => {
                        window.location.href = "index.html"; // O la página principal de tu tienda
                    }, 2000);
                } else {
                    mostrarNotificacion(resultado.mensaje || "❌ Correo o contraseña incorrectos.", "error");
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