/**
 * Lógica principal avanzada y blindada - Lucimakeup Store
 */

document.addEventListener('DOMContentLoaded', () => {
    console.log('Lucimakeup Store - Script principal cargado y blindado correctamente.');

    // ==========================================
    // 1. GESTIÓN DEL FORMULARIO DE CONTACTO (BLINDADO Y CONECTADO)
    // ==========================================
    const formulario = document.querySelector('.formulario');
    const inputNombre = document.getElementById('nombre');
    const inputTelefono = document.getElementById('telefono');
    const inputEmail = document.getElementById('correo'); // 👈 Sincronizado con id="correo" de tu index.html
    const inputMensaje = document.getElementById('mensaje');

    // 🛡️ BLINDAJE EN TIEMPO REAL: Filtrar inputs según su naturaleza
    if (inputTelefono) {
        inputTelefono.addEventListener('input', (e) => {
            // Solo permite números, máximo 10 dígitos
            e.target.value = e.target.value.replace(/[^0-9]/g, '').slice(0, 10);
        });
    }

    if (inputNombre) {
        inputNombre.addEventListener('input', (e) => {
            // Solo permite letras, tildes y espacios
            e.target.value = e.target.value.replace(/[^a-zA-ZáéíóúÁÉÍÓÚñÑ\s]/g, '');
        });
    }

    if (inputEmail) {
        inputEmail.addEventListener('input', (e) => {
            // Remueve caracteres peligrosos para inyecciones XSS
            e.target.value = e.target.value.replace(/[<>"'`;()]/g, '').trim();
        });
    }

    if (formulario) {
        formulario.addEventListener('submit', async function(e) {
            e.preventDefault(); // Evita recarga por defecto

            // Capturar y sanitizar valores
            const nombre = sanitizarTexto(inputNombre ? inputNombre.value.trim() : '');
            const telefono = inputTelefono ? inputTelefono.value.trim() : '';
            const email = sanitizarTexto(inputEmail ? inputEmail.value.trim() : '');
            const mensaje = sanitizarTexto(inputMensaje ? inputMensaje.value.trim() : '');

            // Validación estricta de campos obligatorios
            if (nombre === '' || email === '' || mensaje === '') {
                mostrarAlerta('Por favor, completa los campos obligatorios.', 'error');
                return;
            }

            // Validación de correo electrónico
            const regexCorreo = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (!regexCorreo.test(email)) {
                mostrarAlerta('❌ El formato del correo electrónico no es válido.', 'error');
                if (inputEmail) inputEmail.focus();
                return;
            }

            // Validación opcional de teléfono si se ingresa
            if (telefono && telefono.length < 7) {
                mostrarAlerta('❌ El teléfono debe tener al menos 7 dígitos.', 'error');
                if (inputTelefono) inputTelefono.focus();
                return;
            }

            try {
                // Petición HTTP POST al servidor Node.js mediante ruta relativa (/api/contacto)
                const respuesta = await fetch('/api/contacto', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        nombre: nombre,
                        telefono: telefono,
                        correo: email, // Envía 'correo' tal como lo espera el servidor y la tabla mensaje_contacto
                        mensaje: mensaje
                    })
                });

                const resultado = await respuesta.json();

                if (respuesta.ok && resultado.exito) {
                    mostrarAlerta(`¡Gracias por escribirnos, ${nombre}! Tu mensaje se guardó con éxito.`, 'exito');
                    formulario.reset(); // Limpiamos el formulario
                } else {
                    mostrarAlerta(resultado.mensaje || 'Hubo un error al guardar el mensaje en el servidor.', 'error');
                }

            } catch (error) {
                console.error("Error de red al conectar con el servidor:", error);
                mostrarAlerta('No se pudo conectar con el servidor backend.', 'error');
            }
        });
    }

    // ==========================================
    // 2. FUNCIÓN AUXILIAR PARA ALERTAS VISUALES
    // ==========================================
    function mostrarAlerta(mensaje, tipo) {
        const alertaPrevia = document.querySelector('.alerta-dinamica');
        if (alertaPrevia) {
            alertaPrevia.remove();
        }

        const alerta = document.createElement('div');
        alerta.textContent = mensaje;
        alerta.classList.add('alerta-dinamica');

        alerta.style.position = 'fixed';
        alerta.style.bottom = '20px';
        alerta.style.right = '20px';
        alerta.style.padding = '1.5rem 2rem';
        alerta.style.borderRadius = '0.8rem';
        alerta.style.fontSize = '1.6rem';
        alerta.style.fontFamily = 'Arial, sans-serif';
        alerta.style.boxShadow = '0px 5px 15px rgba(0,0,0,0.2)';
        alerta.style.zIndex = '1000';
        alerta.style.transition = 'opacity 0.3s ease';

        if (tipo === 'error') {
            alerta.style.backgroundColor = '#880e2f';
            alerta.style.color = '#ffffff';
        } else {
            alerta.style.backgroundColor = '#ffc107';
            alerta.style.color = '#212121';
        }

        document.body.appendChild(alerta);

        setTimeout(() => {
            alerta.style.opacity = '0';
            setTimeout(() => alerta.remove(), 300);
        }, 4000);
    }

    // ==========================================
    // 3. INTERACTIVIDAD DEL CARRITO DE COMPRAS
    // ==========================================
    const carritoContainer = document.querySelector('.carrito-container');
    if (carritoContainer) {
        carritoContainer.addEventListener('click', (e) => {
            const badge = carritoContainer.querySelector('.carrito-badge');
            if (badge) {
                let cantidad = parseInt(badge.textContent, 10);
                if (isNaN(cantidad) || cantidad === 0) {
                    console.log('Tu carrito está vacío por ahora.');
                }
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