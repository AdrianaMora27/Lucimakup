/**
 * Lógica del Carrito de Compras - LuciMakeup Store
 * Controla el renderizado desde localStorage, cálculo dinámico, cantidades, eliminación, cupones y envío.
 */

document.addEventListener('DOMContentLoaded', () => {
    console.log("Módulo del carrito cargado correctamente.");
    renderizarYGestionarCarrito();
});

function renderizarYGestionarCarrito() {
    const contenedorCarrito = document.getElementById('lista-carrito');
    const btnAplicarCupon = document.getElementById('btn-aplicar-cupon');
    const btnPagar = document.querySelector('.boton-checkout');

    // 1. Obtener carrito desde localStorage
    let carrito = JSON.parse(localStorage.getItem('lucimakeup_carrito')) || [];

    // Función interna para pintar los productos en la vista
    function pintarProductos() {
        if (!contenedorCarrito) return;

        contenedorCarrito.innerHTML = '';

        if (carrito.length === 0) {
            contenedorCarrito.innerHTML = `
                <div style="text-align: center; padding: 3rem;">
                    <p style="font-size: 1.8rem; color: var(--gris); margin-bottom: 1.5rem;">Tu carrito está vacío.</p>
                    <a href="index.html" class="boton-checkout" style="display: inline-block; width: auto; padding: 1rem 2rem; font-size: 1.6rem; text-decoration: none;">Ir a Comprar</a>
                </div>
            `;
            recalcularTotales();
            return;
        }

        carrito.forEach((producto, index) => {
            const itemDiv = document.createElement('div');
            itemDiv.classList.add('carrito-item');
            itemDiv.innerHTML = `
                <img src="${producto.imagen}" alt="${producto.nombre}" class="carrito-item__imagen">
                <div class="carrito-item__detalles">
                    <h3 class="carrito-item__nombre">${producto.nombre}</h3>
                    <span class="carrito-item__precio">$${Number(producto.precio).toLocaleString('es-CO')} COP</span>
                </div>
                <div class="carrito-item__controles">
                    <input type="number" value="${producto.cantidad}" min="1" class="carrito-item__cantidad" data-index="${index}">
                    <button class="carrito-item__eliminar" data-index="${index}" type="button">Eliminar</button>
                </div>
            `;
            contenedorCarrito.appendChild(itemDiv);
        });

        asignarEventosDinamicos();
        recalcularTotales();
    }

    // 2. Asignar eventos a los inputs de cantidad y botones de eliminar generados dinámicamente
    function asignarEventosDinamicos() {
        const inputsCantidad = document.querySelectorAll('.carrito-item__cantidad');
        const botonesEliminar = document.querySelectorAll('.carrito-item__eliminar');

        inputsCantidad.forEach(input => {
            input.addEventListener('change', (e) => {
                const index = e.target.dataset.index;
                let valor = parseInt(e.target.value);
                if (isNaN(valor) || valor < 1) {
                    valor = 1;
                    e.target.value = 1;
                }
                carrito[index].cantidad = valor;
                localStorage.setItem('lucimakeup_carrito', JSON.stringify(carrito));
                recalcularTotales();
            });
        });

        botonesEliminar.forEach(boton => {
            boton.addEventListener('click', (e) => {
                const index = e.target.dataset.index;
                carrito.splice(index, 1); // Elimina del arreglo
                localStorage.setItem('lucimakeup_carrito', JSON.stringify(carrito));
                pintarProductos(); // Vuelve a pintar la lista y recalcular
            });
        });
    }

    // 3. Escuchar la aplicación del cupón de descuento
    if (btnAplicarCupon) {
        btnAplicarCupon.addEventListener('click', () => {
            const inputCupon = document.getElementById('input-cupon');
            const mensajeCupon = document.getElementById('mensaje-cupon');
            
            if (!inputCupon || !mensajeCupon) return;

            const codigo = inputCupon.value.trim().toUpperCase();
            mensajeCupon.style.display = 'block';

            if (codigo === "LUCI10") {
                mensajeCupon.textContent = "¡Cupón aplicado con éxito! 10% de descuento.";
                mensajeCupon.style.color = "#2e7d32"; 
                inputCupon.dataset.descuento = "0.10"; 
            } else if (codigo === "") {
                mensajeCupon.textContent = "Por favor, ingresa un código de cupón.";
                mensajeCupon.style.color = "#880e2f";
                inputCupon.dataset.descuento = "0";
            } else {
                mensajeCupon.textContent = "El código ingresado no es válido o ha expirado.";
                mensajeCupon.style.color = "#880e2f"; 
                inputCupon.dataset.descuento = "0";
            }
            recalcularTotales();
        });
    }

    // 4. Interceptar el botón de pagar
    if (btnPagar) {
        btnPagar.addEventListener('click', () => {
            const totalTexto = document.getElementById('total-texto');
            if (totalTexto) {
                localStorage.setItem('lucimakeup_total_pagar', totalTexto.textContent);
            }
        });
    }

    // Inicializar pintando los elementos al cargar
    pintarProductos();
}

/**
 * Función central para calcular Subtotal, Descuentos, Envío y Total basado en los datos reales
 */
function recalcularTotales() {
    let carrito = JSON.parse(localStorage.getItem('lucimakeup_carrito')) || [];
    let subtotalProductos = 0;

    carrito.forEach(item => {
        subtotalProductos += (Number(item.precio) * Number(item.cantidad));
    });

    const inputCupon = document.getElementById('input-cupon');
    let tasaDescuento = inputCupon && inputCupon.dataset.descuento ? parseFloat(inputCupon.dataset.descuento) : 0;
    let valorDescuento = subtotalProductos * tasaDescuento;
    let subtotalConDescuento = subtotalProductos - valorDescuento;

    let costoEnvio = 8000; // Envío base por defecto
    if (subtotalConDescuento >= 200000 || subtotalConDescuento === 0) {
        costoEnvio = 0; 
    }

    let totalFinal = subtotalConDescuento + costoEnvio;

    const subtotalDOM = document.getElementById('subtotal-texto');
    const envioDOM = document.getElementById('envio-texto');
    const totalDOM = document.getElementById('total-texto');

    if (subtotalDOM) subtotalDOM.textContent = `$${subtotalProductos.toLocaleString('es-CO')} COP`;
    if (envioDOM) {
        envioDOM.textContent = costoEnvio === 0 ? "¡Gratis! ($0 COP)" : `$${costoEnvio.toLocaleString('es-CO')} COP`;
    }
    if (totalDOM) totalDOM.textContent = `$${totalFinal.toLocaleString('es-CO')} COP`;
}