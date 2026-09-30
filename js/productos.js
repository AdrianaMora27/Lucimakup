// ==========================================
// BASE DE DATOS LOCAL DE PRODUCTOS (Sincronizada con MySQL)
// ==========================================
const productos = [
    // Papelería (IDs 101 - 111)
    { idProducto: 101, Nombre_Producto: "Lapicero con diseño", descripcion_producto: "Lapicero con tinta fluida y diseños variados.", Precio_Producto: 5000.00, Stock_Producto: 15, Categoria_idCategoria: 1, imagen: "img/lapicerosDiseños.jpeg" },
    { idProducto: 102, Nombre_Producto: "Lápiz porta mina", descripcion_producto: "Lápiz portaminas ergonómico para alta precisión.", Precio_Producto: 6500.00, Stock_Producto: 10, Categoria_idCategoria: 1, imagen: "img/lapizMina.jpeg" },
    { idProducto: 103, Nombre_Producto: "Cartuchera con diseño", descripcion_producto: "Cartuchera organizadora amplia con cierre.", Precio_Producto: 18000.00, Stock_Producto: 10, Categoria_idCategoria: 1, imagen: "img/cartuchera.jpeg" },
    { idProducto: 104, Nombre_Producto: "Resaltadores con diseño", descripcion_producto: "Set de resaltadores en tonos pastel o fluorescentes.", Precio_Producto: 12000.00, Stock_Producto: 10, Categoria_idCategoria: 1, imagen: "img/resaltadores.jpeg" },
    { idProducto: 105, Nombre_Producto: "Cuadernos surtidos", descripcion_producto: "Cuadernos pasta dura con motivos ilustrados.", Precio_Producto: 8000.00, Stock_Producto: 10, Categoria_idCategoria: 1, imagen: "img/cuadernos.jpeg" },
    { idProducto: 106, Nombre_Producto: "Carpeta plástica", descripcion_producto: "Carpeta organizadora para documentos.", Precio_Producto: 4500.00, Stock_Producto: 10, Categoria_idCategoria: 1, imagen: "img/carpeta.jpeg" },
    { idProducto: 107, Nombre_Producto: "Cuaderno Zootopia", descripcion_producto: "Cuaderno edición especial Zootopia.", Precio_Producto: 9500.00, Stock_Producto: 10, Categoria_idCategoria: 1, imagen: "img/cuadernoZootopia.jpeg" },
    { idProducto: 108, Nombre_Producto: "Block iris", descripcion_producto: "Block de papel iris en múltiples colores.", Precio_Producto: 7000.00, Stock_Producto: 10, Categoria_idCategoria: 1, imagen: "img/block.jpeg" },
    { idProducto: 109, Nombre_Producto: "Morral unisex", descripcion_producto: "Morral resistente con múltiples compartimentos.", Precio_Producto: 45000.00, Stock_Producto: 10, Categoria_idCategoria: 1, imagen: "img/morrales.jpeg" },
    { idProducto: 110, Nombre_Producto: "Llavero surtido", descripcion_producto: "Llaveros decorativos con figuras variadas.", Precio_Producto: 4000.00, Stock_Producto: 10, Categoria_idCategoria: 1, imagen: "img/llavero.jpeg" },
    { idProducto: 111, Nombre_Producto: "Llavero gato", descripcion_producto: "Llavero de silicona suave en forma de gato.", Precio_Producto: 5000.00, Stock_Producto: 10, Categoria_idCategoria: 1, imagen: "img/llaveroGato.jpeg" },

    // Cuidado Personal y Maquillaje (IDs 201 - 205)
    { idProducto: 201, Nombre_Producto: "Mascarilla Facial Bioaqua", descripcion_producto: "Mascarilla facial hidratante para el cuidado de la piel y nutrición profunda.", Precio_Producto: 5000.00, Stock_Producto: 20, Categoria_idCategoria: 2, imagen: "img/MascarillasHidratantes.jpeg" },
    { idProducto: 202, Nombre_Producto: "Polvo Compacto Matte", descripcion_producto: "Polvo compacto con acabado matte de larga duración.", Precio_Producto: 38000.00, Stock_Producto: 10, Categoria_idCategoria: 2, imagen: "img/gelCejas.jpeg" },
    { idProducto: 203, Nombre_Producto: "Corrector Líquido de Ojeras", descripcion_producto: "Corrector líquido de alta cobertura para imperfecciones y ojeras.", Precio_Producto: 25000.00, Stock_Producto: 10, Categoria_idCategoria: 2, imagen: "img/sombras.jpeg" },
    { idProducto: 204, Nombre_Producto: "Paleta de Sombras Nude", descripcion_producto: "Paleta de sombras de alta pigmentación con tonos versátiles.", Precio_Producto: 65000.00, Stock_Producto: 10, Categoria_idCategoria: 2, imagen: "img/sombrasGlitter.jpeg" },
    { idProducto: 205, Nombre_Producto: "Pestañina Volumen Extremo", descripcion_producto: "Pestañina especializada para dar volumen y alargamiento extremo.", Precio_Producto: 30000.00, Stock_Producto: 10, Categoria_idCategoria: 2, imagen: "img/mascarilla.jpeg" },

    // Estilo y Vida (IDs 301 - 306)
    { idProducto: 301, Nombre_Producto: "Termo térmico de acero", descripcion_producto: "Termo de acero inoxidable para mantener bebidas frías o calientes.", Precio_Producto: 35000.00, Stock_Producto: 10, Categoria_idCategoria: 3, imagen: "img/termo.jpg" },
    { idProducto: 302, Nombre_Producto: "Espejo con diseño", descripcion_producto: "Espejo decorativo con marco de diseño moderno y elegante.", Precio_Producto: 45000.00, Stock_Producto: 10, Categoria_idCategoria: 3, imagen: "img/espejo.jpeg" },
    { idProducto: 303, Nombre_Producto: "Soporte para computador portátil", descripcion_producto: "Soporte ergonómico ajustable para laptop y mejora postural.", Precio_Producto: 55000.00, Stock_Producto: 10, Categoria_idCategoria: 3, imagen: "img/soporteLaptop.jpeg" },
    { idProducto: 304, Nombre_Producto: "Difusor de aroma electrónico", descripcion_producto: "Difusor ultrasónico de aromas con iluminación LED ambiental.", Precio_Producto: 48000.00, Stock_Producto: 10, Categoria_idCategoria: 3, imagen: "img/difusor.jpeg" },
    { idProducto: 305, Nombre_Producto: "Vela con aroma", descripcion_producto: "Vela aromática artesanal en recipiente protector.", Precio_Producto: 22000.00, Stock_Producto: 10, Categoria_idCategoria: 3, imagen: "img/vela.jpeg" },
    { idProducto: 306, Nombre_Producto: "Aceite esencial Lavanda", descripcion_producto: "Aceite esencial concentrado con relajante aroma a lavanda.", Precio_Producto: 18000.00, Stock_Producto: 10, Categoria_idCategoria: 3, imagen: "img/aceiteLavanda.jpeg" },

    // Productos adicionales / Capilares (IDs 400 - 408)
    { idProducto: 400, Nombre_Producto: "Acondicionador", descripcion_producto: "Acondicionador nutritivo para suavidad y brillo capilar.", Precio_Producto: 15000.00, Stock_Producto: 10, Categoria_idCategoria: 2, imagen: "img/cuidadocapilar.jpeg" },
    { idProducto: 401, Nombre_Producto: "Shampoo Todo tipo", descripcion_producto: "Shampoo formulado para limpieza profunda en todo tipo de cabello.", Precio_Producto: 18000.00, Stock_Producto: 10, Categoria_idCategoria: 2, imagen: "img/shampoo.jpeg" },
    { idProducto: 402, Nombre_Producto: "Crema de peinar", descripcion_producto: "Crema para peinar ideal para definición y control de frizz.", Precio_Producto: 20000.00, Stock_Producto: 10, Categoria_idCategoria: 2, imagen: "img/cremaPeinar.jpeg" },
    { idProducto: 403, Nombre_Producto: "Aceite de coco corporal", descripcion_producto: "Aceite de coco hidratante para nutrición corporal profunda.", Precio_Producto: 22000.00, Stock_Producto: 10, Categoria_idCategoria: 2, imagen: "img/cuidadocorporal.jpeg" },
    { idProducto: 404, Nombre_Producto: "Mantequilla corporal", descripcion_producto: "Mantequilla corporal hidratante con textura suave.", Precio_Producto: 25000.00, Stock_Producto: 10, Categoria_idCategoria: 2, imagen: "img/mantequilla.jpeg" },
    { idProducto: 405, Nombre_Producto: "Perfume con Glitter", descripcion_producto: "Perfume corporal con destellos brillantes de glitter.", Precio_Producto: 30000.00, Stock_Producto: 10, Categoria_idCategoria: 2, imagen: "img/perfumeGlitter.jpeg" },
    { idProducto: 406, Nombre_Producto: "Gel de cejas", descripcion_producto: "Gel fijador transparente de larga duración para cejas perfectas.", Precio_Producto: 15000.00, Stock_Producto: 10, Categoria_idCategoria: 2, imagen: "img/gelcejas.jpeg" },
    { idProducto: 407, Nombre_Producto: "Rubor en barra", descripcion_producto: "Rubor en barra de fácil difuminado para un efecto natural.", Precio_Producto: 24000.00, Stock_Producto: 10, Categoria_idCategoria: 2, imagen: "img/ruborBarra.jpeg" },
    { idProducto: 408, Nombre_Producto: "Blush Líquido", descripcion_producto: "Rubor líquido de alta pigmentación y acabado fresco.", Precio_Producto: 22000.00, Stock_Producto: 10, Categoria_idCategoria: 2, imagen: "img/blushLiquido.jpeg" }
];

// ==========================================
// LÓGICA DE DETALLE (productos.html)
// ==========================================
document.addEventListener('DOMContentLoaded', () => {
    const parametrosURL = new URLSearchParams(window.location.search);
    const productoIdURL = parseInt(parametrosURL.get('id'));

    if (productoIdURL) {
        const productoEncontrado = productos.find(p => p.idProducto === productoIdURL);
        const contenedorDetalle = document.querySelector('.producto-detalle');
        
        if (productoEncontrado && contenedorDetalle) {
            contenedorDetalle.innerHTML = `
                <div class="producto-imagen-grande">
                    <img src="${productoEncontrado.imagen}" alt="${productoEncontrado.Nombre_Producto}">
                </div>
                <div class="producto-info-detalle">
                    <h1>${productoEncontrado.Nombre_Producto}</h1>
                    <p class="precio-detalle">$${Number(productoEncontrado.Precio_Producto).toLocaleString()} COP</p>
                    <p class="descripcion-detalle">${productoEncontrado.descripcion_producto}</p>
                    <p class="stock-detalle">Disponibles: <strong>${productoEncontrado.Stock_Producto} unidades</strong></p>
                    <button class="btn-agregar-carrito" data-id="${productoEncontrado.idProducto}">Añadir al carrito</button>
                </div>
            `;

            // Funcionalidad del botón agregar al carrito
            const botonAgregar = document.querySelector('.btn-agregar-carrito');
            if (botonAgregar) {
                botonAgregar.addEventListener('click', () => {
                    let carrito = JSON.parse(localStorage.getItem('lucimakeup_carrito')) || [];
                    
                    const indexExistente = carrito.findIndex(item => item.id === productoEncontrado.idProducto);
                    if (indexExistente >= 0) {
                        carrito[indexExistente].cantidad += 1;
                    } else {
                        carrito.push({
                            id: productoEncontrado.idProducto,
                            nombre: productoEncontrado.Nombre_Producto,
                            precio: productoEncontrado.Precio_Producto,
                            imagen: productoEncontrado.imagen,
                            cantidad: 1
                        });
                    }
                    localStorage.setItem('lucimakeup_carrito', JSON.stringify(carrito));
                    alert('¡Producto añadido al carrito con éxito!');
                });
            }
        } else {
            if (contenedorDetalle) {
                contenedorDetalle.innerHTML = `<h2>Lo sentimos, el producto no fue encontrado.</h2>`;
            }
        }
    }
});