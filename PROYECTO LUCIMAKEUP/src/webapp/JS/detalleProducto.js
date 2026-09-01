document.addEventListener("DOMContentLoaded", () => {
    //1.Capturar el ID desde la URL (ejemplo: producto.hmtl?id=1)
    const parametroURL = new URLSearchParams(window.location.search);
    const idProducto = parseInt(parametrosURL.get("id"));

    //2Elemento HTML donde se escribira la informacion
    const contenedor = document.getElementById("detalle-producto");

    if (!contenedor || typeof productosDB === "Undefined"){
        console.error("Falta el contendor o la base de datos de productos");
        return;
    }
    //3.Buscar el producto en productosDB
    const producto = productosDB.find(p => p.id === idProducto);

    //4.renderizar la informacion
    if(producto) {
        contenedor.innerHTML = `
            <div class="producto-detalle">
                <div class="producto-detalle__imagen">
                    <img src="${producto.imagen}" alt="${producto.nombre}">
                </div>
                <div class="producto-detalle__info">
                    <h2>${producto.nombre}</h2>
                    <p class="producto-detalle__precio">$${producto.precio.toLocaleString('es-CO')}</p>
                    <p class="producto-detalle__descripcion">${producto.descripcion}</p>
                    
                    <div class="producto-detalle__acciones">
                        <label for="cantidad">Cantidad:</label>
                        <input type="number" id="cantidad" value="1" min="1" class="input-cantidad">
                        <button onclick="agregarAlCarrito(${producto.id})" class="boton boton--primario">
                            Agregar al Carrito
                        </button>
                    </div>
                </div>
            </div>
        `;
    } else {
        contenedor.innerHTML = `
            <div style="text-align: center; padding: 2rem;">
                <h2>Producto no encontrado</h2>
                <p>El producto seleccionado no está disponible en la base de datos.</p>
                <a href="categorias.html" class="boton">Volver al catálogo</a>
            </div>
        `;
    }
});