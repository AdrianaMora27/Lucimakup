document.addEventListener('DOMContentLoaded', () => {
    console.log('Lucimakeup Store - Script principal cargado correctamente.');

    // ==========================================
    // 1. GESTIÓN DEL FORMULARIO DE CONTACTO (CONEXIÓN BACKEND)
    // ==========================================
    const formulario = document.querySelector('.formulario');

    if (formulario) {
        formulario.addEventListener('submit', async function(e) {
            e.preventDefault(); // Evita que la página se recargue por defecto

            // Obtenemos los valores de los campos
            const nombre = document.getElementById('nombre').value.trim();
            const telefono = document.getElementById('telefono').value.trim();
            const email = document.getElementById('email').value.trim();
            const mensaje = document.getElementById('mensaje').value.trim();

            // Validación simple
            if (nombre === '' || email === '' || mensaje === '') {
                mostrarAlerta('Por favor, completa los campos obligatorios.', 'error');
                return;
            }

            try {
                // Petición HTTP POST al servidor Node.js (phpMyAdmin)
                const respuesta = await fetch('http://localhost:3000/api/contacto', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        nombre: nombre,
                        telefono: telefono,
                        correo: email,
                        mensaje: mensaje
                    })
                });

                const resultado = await respuesta.json();

                if (resultado.exito) {
                    // Mensaje de éxito integrado con la base de datos
                    mostrarAlerta(`¡Gracias por escribirnos, ${nombre}! Tu mensaje se guardó con éxito.`, 'exito');
                    formulario.reset(); // Limpiamos el formulario
                } else {
                    mostrarAlerta('Hubo un error al guardar el mensaje en el servidor.', 'error');
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
        // Evitamos crear múltiples alertas acumuladas
        const alertaPrevia = document.querySelector('.alerta-dinamica');
        if (alertaPrevia) {
            alertaPrevia.remove();
        }

        const alerta = document.createElement('div');
        alerta.textContent = mensaje;
        alerta.classList.add('alerta-dinamica');

        // Estilos dinámicos para la alerta
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

        // Desaparece automáticamente a los 4 segundos
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
                let cantidad = parseInt(badge.textContent);
                if (cantidad === 0) {
                    console.log('Tu carrito está vacío por ahora.');
                }
            }
        });
    }
});