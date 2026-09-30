/**
 * Lógica del Carrito de Compras - LuciMakeup Store
 * Controla el cálculo dinámico, cantidades, eliminación, cupones y regla de envío gratis.
 */

document.addEventListener('DOMContentLoaded', () => {
    console.log("Módulo del carrito cargado correctamente.");
    inicializarCarrito();
});

function inicializarCarrito() {
    const inputsCantidad = document.querySelectorAll('.carrito-item__cantidad');
    const botonesEliminar = document.querySelectorAll('.carrito-item__eliminar');
    const btnAplicarCupon = document.getElementById('btn-aplicar-cupon');
    const btnPagar = document.querySelector('.boton-checkout');

    // 1. Escuchar cambios en los inputs de cantidad
    inputsCantidad.forEach(input => {
        input.addEventListener('change', (e) => {
            let valor = parseInt(e.target.value);
            if (isNaN(valor) || valor < 1) {
                e.target.value = 1; // Prevenir cantidades negativas o vacías
            }
            recalcularTotales();
        });
    });

    // 2. Escuchar clics en los botones de eliminar producto
    botonesEliminar.forEach(boton => {
        boton.addEventListener('click', (e) => {
            const item = e.target.closest('.carrito-item');
            if (item) {
                item.remove(); // Elimina visualmente el producto de la tabla
                recalcularTotales();
            }
        });
    });

    // 3. Escuchar la aplicación del cupón de descuento de forma visual
    if (btnAplicarCupon) {
        btnAplicarCupon.addEventListener('click', () => {
            const inputCupon = document.getElementById('input-cupon');
            const mensajeCupon = document.getElementById('mensaje-cupon');
            const codigo = inputCupon.value.trim().toUpperCase();

            // Asegurarnos de que el contenedor del mensaje sea visible
            mensajeCupon.style.display = 'block';

            if (codigo === "LUCI10") {
                mensajeCupon.textContent = "¡Cupón aplicado con éxito! 10% de descuento.";
                mensajeCupon.style.color = "#2e7d32"; // Color verde elegante
                inputCupon.dataset.descuento = "0.10"; 
            } else if (codigo === "") {
                mensajeCupon.textContent = "Por favor, ingresa un código de cupón.";
                mensajeCupon.style.color = "var(--rojo-alerta)";
                inputCupon.dataset.descuento = "0";
            } else {
                mensajeCupon.textContent = "El código ingresado no es válido o ha expirado.";
                mensajeCupon.style.color = "var(--rojo-alerta)"; 
                inputCupon.dataset.descuento = "0";
            }
            recalcularTotales();
        });
    }

    // 4. Interceptar el botón de pagar para asegurar la persistencia antes de ir al checkout
    if (btnPagar) {
        btnPagar.addEventListener('click', () => {
            const totalTexto = document.getElementById('total-texto').textContent;
            localStorage.setItem('lucimakeup_total_pagar', totalTexto);
        });
    }

    // Cálculo inicial al cargar la página
    recalcularTotales();
}

/**
 * Función central de negocio para calcular Subtotal, Descuentos, Envío y Total
 */
function recalcularTotales() {
    const items = document.querySelectorAll('.carrito-item');
    let subtotalProductos = 0;

    // Recorrer cada producto visible en la tabla para sumar su precio x cantidad
    items.forEach(item => {
        const precioTexto = item.querySelector('.carrito-item__precio').textContent;
        const precioUnitario = parseFloat(precioTexto.replace(/[^0-9]/g, ''));
        const cantidad = parseInt(item.querySelector('.carrito-item__cantidad').value);

        subtotalProductos += (precioUnitario * cantidad);
    });

    // Verificar si hay un cupón activo aplicado
    const inputCupon = document.getElementById('input-cupon');
    let tasaDescuento = inputCupon && inputCupon.dataset.descuento ? parseFloat(inputCupon.dataset.descuento) : 0;
    let valorDescuento = subtotalProductos * tasaDescuento;

    // Subtotal final restando los descuentos por cupones
    let subtotalConDescuento = subtotalProductos - valorDescuento;

    // Regla de Negocio: Envío gratis si la compra supera o iguala los $200.000 COP
    let costoEnvio = 8000; // Envío base por defecto
    if (subtotalConDescuento >= 200000 || subtotalConDescuento === 0) {
        costoEnvio = 0; // Envío gratis
    }

    // Calcular Total Final
    let totalFinal = subtotalConDescuento + costoEnvio;

    // Actualizar los valores en el DOM de la vista HTML
    document.getElementById('subtotal-texto').textContent = `$${subtotalProductos.toLocaleString('es-CO')} COP`;
    
    const envioTexto = costoEnvio === 0 ? "¡Gratis! ($0 COP)" : `$${costoEnvio.toLocaleString('es-CO')} COP`;
    document.getElementById('envio-texto').textContent = envioTexto;

    document.getElementById('total-texto').textContent = `$${totalFinal.toLocaleString('es-CO')} COP`;
}