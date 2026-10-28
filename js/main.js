/**
 * Lógica principal avanzada y blindada - Lucimakeup Store
 */

document.addEventListener('DOMContentLoaded', () => {
    console.log('Lucimakeup Store - Script principal cargado y blindado correctamente.');

    // ==========================================
    // 1. GESTIÓN DEL FORMULARIO DE CONTACTO
    // ==========================================
    const formulario = document.querySelector('.formulario');
    const inputNombre = document.getElementById('nombre');
    const inputTelefono = document.getElementById('telefono');
    const inputEmail = document.getElementById('correo');
    const inputMensaje = document.getElementById('mensaje');

    if (inputTelefono) {
        inputTelefono.addEventListener('input', (e) => {
            e.target.value = e.target.value.replace(/[^0-9]/g, '').slice(0, 10);
        });
    }

    if (inputNombre) {
        inputNombre.addEventListener('input', (e) => {
            e.target.value = e.target.value.replace(/[^a-zA-ZáéíóúÁÉÍÓÚñÑ\s]/g, '');
        });
    }

    if (inputEmail) {
        inputEmail.addEventListener('input', (e) => {
            e.target.value = e.target.value.replace(/[<>"'`;()]/g, '').trim();
        });
    }

    if (formulario) {
        formulario.addEventListener('submit', async function(e) {
            e.preventDefault();

            const nombre = sanitizarTexto(inputNombre ? inputNombre.value.trim() : '');
            const telefono = inputTelefono ? inputTelefono.value.trim() : '';
            const email = sanitizarTexto(inputEmail ? inputEmail.value.trim() : '');
            const mensaje = sanitizarTexto(inputMensaje ? inputMensaje.value.trim() : '');

            if (nombre === '' || email === '' || mensaje === '') {
                mostrarAlerta('Por favor, completa los campos obligatorios.', 'error');
                return;
            }

            const regexCorreo = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (!regexCorreo.test(email)) {
                mostrarAlerta('❌ El formato del correo electrónico no es válido.', 'error');
                if (inputEmail) inputEmail.focus();
                return;
            }

            if (telefono && telefono.length < 7) {
                mostrarAlerta('❌ El teléfono debe tener al menos 7 dígitos.', 'error');
                if (inputTelefono) inputTelefono.focus();
                return;
            }

            try {
                const respuesta = await fetch('/api/contacto', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ nombre, telefono, correo: email, mensaje })
                });

                const resultado = await respuesta.json();

                if (respuesta.ok && resultado.exito) {
                    mostrarAlerta(`¡Gracias por escribirnos, ${nombre}! Tu mensaje se guardó con éxito.`, 'exito');
                    formulario.reset();
                } else {
                    mostrarAlerta(resultado.mensaje || 'Hubo un error al guardar el mensaje.', 'error');
                }

            } catch (error) {
                console.error("Error de red:", error);
                mostrarAlerta('No se pudo conectar con el servidor backend.', 'error');
            }
        });
    }

    // ==========================================
    // 2. INTERACTIVIDAD DEL CARRITO DE COMPRAS
    // ==========================================
    const carritoContainer = document.querySelector('.carrito-container');
    if (carritoContainer) {
        carritoContainer.addEventListener('click', () => {
            const badge = carritoContainer.querySelector('.carrito-badge');
            if (badge) {
                let cantidad = parseInt(badge.textContent, 10);
                if (isNaN(cantidad) || cantidad === 0) {
                    console.log('Tu carrito está vacío por ahora.');
                }
            }
        });
    }

    // ==========================================
    // 3. GESTIÓN DE CIERRE DE SESIÓN
    // ==========================================
    const btnCerrarSesion = document.getElementById("btn-cerrar-sesion") || document.getElementById("btnCerrarSesion");

    if (btnCerrarSesion) {
        btnCerrarSesion.addEventListener("click", (e) => {
            e.preventDefault();
            localStorage.removeItem("lucimakeup_usuario");
            localStorage.removeItem("usuario");
            localStorage.removeItem("token");
            sessionStorage.clear();

            mostrarNotificacionEstetica("✨ ¡Sesión cerrada correctamente! Hasta pronto.", "success");

            setTimeout(() => {
                window.location.href = "index.html";
            }, 1200);
        });
    }

    // ==========================================
    // 4. BUSCADOR GLOBAL UNIFICADO (ÚNICA DECLARACIÓN)
    // ==========================================
    const inputBuscador = document.getElementById('inputBuscador');
    
    if (inputBuscador) {
        const botonBuscar = inputBuscador.nextElementSibling || inputBuscador.parentElement.querySelector('button, .fa-search, img');

        const procesarBusquedaGlobal = (e) => {
            if (e.key === 'Enter' || e.type === 'click') {
                if (e.key === 'Enter') e.preventDefault();

                const texto = inputBuscador.value.toLowerCase().trim();
                if (texto === '') return;

                // Redirige a categorias.html con el término buscado
                window.location.href = `categorias.html?busqueda=${encodeURIComponent(texto)}`;
            }
        };

        inputBuscador.addEventListener('keydown', procesarBusquedaGlobal);
        if (botonBuscar) {
            botonBuscar.addEventListener('click', procesarBusquedaGlobal);
        }
    }

    // ==========================================
    // 5. AUTO-FILTRADO Y VISTA EN CATEGORIAS.HTML
    // ==========================================
    const urlParams = new URLSearchParams(window.location.search);
    const busquedaActiva = urlParams.get('busqueda');

    if (busquedaActiva && window.location.pathname.includes('categorias.html')) {
        if (inputBuscador) {
            inputBuscador.value = busquedaActiva;
        }

        // Actualizar el título principal para mostrar el término buscado
        const tituloSeccion = document.querySelector('h1, h2, .titulo-catalogo, .titulo-pagina');
        if (tituloSeccion) {
            tituloSeccion.textContent = `Resultados para: "${busquedaActiva}"`;
        }

        // Filtrar tarjetas en pantalla si existen
        const tarjetas = document.querySelectorAll('.tarjeta-producto, .producto-card, .card');
        let encontrados = 0;

        tarjetas.forEach(tarjeta => {
            if (tarjeta.textContent.toLowerCase().includes(busquedaActiva.toLowerCase())) {
                tarjeta.style.display = '';
                encontrados++;
            } else {
                tarjeta.style.display = 'none';
            }
        });

        // Si la página estática de categorías no contiene productos directos en su HTML
        if (encontrados === 0 && tarjetas.length === 0) {
            const main = document.querySelector('main') || document.body;
            let aviso = document.getElementById('sin-resultados-msg');
            
            if (!aviso) {
                aviso = document.createElement('div');
                aviso.id = 'sin-resultados-msg';
                aviso.style.cssText = "text-align: center; padding: 4rem 2rem; font-size: 1.6rem; color: #880e2f; width: 100%;";
                main.appendChild(aviso);
            }
            aviso.innerHTML = `🔍 Buscando productos para <strong>"${busquedaActiva}"</strong>...`;
        }
    }

});

// ==========================================
// FUNCIONES AUXILIARES GLOBALES
// ==========================================

function mostrarAlerta(mensaje, tipo) {
    const alertaPrevia = document.querySelector('.alerta-dinamica');
    if (alertaPrevia) alertaPrevia.remove();

    const alerta = document.createElement('div');
    alerta.textContent = mensaje;
    alerta.classList.add('alerta-dinamica');

    alerta.style.cssText = `
        position: fixed;
        bottom: 20px;
        right: 20px;
        padding: 1.5rem 2rem;
        border-radius: 0.8rem;
        font-size: 1.6rem;
        font-family: Arial, sans-serif;
        box-shadow: 0px 5px 15px rgba(0,0,0,0.2);
        z-index: 1000;
        transition: opacity 0.3s ease;
        background-color: ${tipo === 'error' ? '#880e2f' : '#ffc107'};
        color: ${tipo === 'error' ? '#ffffff' : '#212121'};
    `;

    document.body.appendChild(alerta);

    setTimeout(() => {
        alerta.style.opacity = '0';
        setTimeout(() => alerta.remove(), 300);
    }, 4000);
}

function mostrarNotificacionEstetica(mensaje, tipo = "success") {
    let contenedor = document.getElementById("toast-container");
    if (!contenedor) {
        contenedor = document.createElement("div");
        contenedor.id = "toast-container";
        contenedor.style.cssText = "position: fixed; top: 20px; right: 20px; z-index: 99999; display: flex; flex-direction: column; gap: 10px;";
        document.body.appendChild(contenedor);
    }

    const toast = document.createElement("div");
    const bgColor = tipo === "success" ? "#880e2f" : "#d32f2f";
    
    toast.style.cssText = `
        min-width: 300px;
        max-width: 400px;
        padding: 16px 20px;
        border-radius: 10px;
        color: #ffffff;
        font-family: 'Arial', sans-serif;
        font-size: 1.5rem;
        background-color: ${bgColor};
        box-shadow: 0 6px 16px rgba(0,0,0,0.25);
        display: flex;
        align-items: center;
        justify-content: space-between;
        opacity: 0;
        transform: translateY(-20px);
        transition: opacity 0.3s ease, transform 0.3s ease;
    `;
    
    toast.innerHTML = `<span>${mensaje}</span>`;
    contenedor.appendChild(toast);

    setTimeout(() => {
        toast.style.opacity = "1";
        toast.style.transform = "translateY(0)";
    }, 10);

    setTimeout(() => {
        toast.style.opacity = "0";
        toast.style.transform = "translateY(-20px)";
        setTimeout(() => toast.remove(), 300);
    }, 3500);
}

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