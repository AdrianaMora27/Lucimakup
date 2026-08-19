/**
 * Proyecto: Lucimakeup Store
 * Funcionalidad: Gestion del carrito de compras (Front-end)
 */

//1. Obtener carrito del localStorage o iniciarlizarlo vacio
let carrito = JSON.parse(localStorage.getItem('lucimakeup_carrito')) || [];

//2. Funcion para agregar un producto al carrito
function agregarAlCarrito(id, nombre, precio, imagen) {
    //Verificar si el producto ya esta en el carrito
    const existe = carrito.find(producto => producto.id === id);

    if(existe) {
        existe.cantidad += 1;

    } else {
        carrito.push({
            id: id,
            nombre: nombre,
            precio: parseFloat(precio),
            imagen: imagen,
            cantidad: 1
        });
    }


//Guardar en el localStorage y actualizar interfaz
guardarCarrito();
actualizarContador();
alert (`¡${nombre} se agrego al carrito con éxito!`);
}

//3. Guardar el estado actual del carrito en el navegador
function guardarCarrito() {
    localStorage.setItem('lucimakeup_carrito', JSON.stringify(carrito));
}

//4. Actualizar el contador numerico en el icono del carrito
function actualizarContador() {
    const contadorElem = document.querySelector('#contador-carrito');
    if(contadorElem) {
        const totalItems = carrito.reduce((sum, prod) => sum + prod.cantidad, 0);
        contadorElem.textContent = totalItems;
    }
}

// 5. Cargar el carrito visualmente si estamos en carrito.html
function renderizarCarrito() {
    const contenedor = document.querySelector('#lista-carrito');
    const totalElem = document.querySelector('#total-precio');

    if (!contenedor) return; // Si no está en la página del carrito, no hace nada

    contenedor.innerHTML = '';

    if (carrito.length === 0) {
        contenedor.innerHTML = '<tr><td colspan="5" style="text-align:center;">El carrito está vacío.</td></tr>';
        if (totalElem) totalElem.textContent = '$0.00';
        return;
    }

    let total = 0;

    carrito.forEach((producto, index) => {
        const subtotal = producto.precio * producto.cantidad;
        total += subtotal;

        const fila = document.createElement('tr');
        fila.innerHTML = `
            <td><img src="${producto.imagen}" width="60" alt="${producto.nombre}"></td>
            <td>${producto.nombre}</td>
            <td>$${producto.precio.toLocaleString()}</td>
            <td>
                <button onclick="cambiarCantidad(${index}, -1)">-</button>
                <span>${producto.cantidad}</span>
                <button onclick="cambiarCantidad(${index}, 1)">+</button>
            </td>
            <td>$${subtotal.toLocaleString()}</td>
            <td><button onclick="eliminarProducto(${index})" class="btn-eliminar">❌</button></td>
        `;
        contenedor.appendChild(fila);
    });

    if (totalElem) {
        totalElem.textContent = `$${total.toLocaleString()}`;
    }
}

//6.Cambiar cantidad de un producto

function cambiarCantidad(index, cambio) {
    carrito[index]. cantidad += cambio;
    if (carrito[index].cantidad <= 0) {
        carrito.splice(index, 1);
    }
    guardarCarrito();
    renderizarCarrito();
    actualizarContador();

}

//Eliminar producto del carrito
function eliminarProducto(index) {
    carrito.splice(index, 1);
    guardarCarrito();
    renderizarCarrito();
    actualizarContador();
}

//Ejecutar el cargar la pagina
document.addEventListener('DOMContentLoaded', () => {
    actualizarContador();
    renderizarCarrito();
});
