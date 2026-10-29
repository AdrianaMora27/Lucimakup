document.addEventListener("DOMContentLoaded", () => {
    // 1. Validar seguridad de rol Administrador
    const usuarioLogueado = JSON.parse(localStorage.getItem("lucimakeup_usuario") || localStorage.getItem("usuarioLogueado"));
    
    if (!usuarioLogueado || usuarioLogueado.rol !== "admin") {
        alert("❌ Acceso denegado. Esta sección es exclusiva para administradores.");
        window.location.href = "index.html";
        return;
    }

    const formProducto = document.getElementById("form-producto");
    const tablaBody = document.getElementById("tabla-productos-body");
    const btnSubmitText = document.getElementById("btn-submit-text");

    // Función para listar productos en la tabla
    async function cargarProductosAdmin() {
        try {
            const respuesta = await fetch("http://localhost:3000/api/productos");
            const resultado = await respuesta.json();
            
            // Soportar tanto si devuelve array directo o {exito: true, productos: [...]}
            const productos = Array.isArray(resultado) ? resultado : (resultado.productos || []);

            tablaBody.innerHTML = "";
            productos.forEach(prod => {
                const tr = document.createElement("tr");
                tr.innerHTML = `
                    <td>${prod.idProducto}</td>
                    <td><strong>${prod.Nombre_Producto}</strong></td>
                    <td>$${Number(prod.Precio_Producto).toLocaleString()}</td>
                    <td>${prod.Stock_Producto} un.</td>
                    <td>ID: ${prod.Categoria_idCategoria}</td>
                    <td>
                        <div class="acciones-btn">
                            <button class="btn-editar" onclick='prepararEdicion(${JSON.stringify(prod)})'>Editar</button>
                            <button class="btn-eliminar" onclick="eliminarProducto(${prod.idProducto})">Eliminar</button>
                        </div>
                    </td>
                `;
                tablaBody.appendChild(tr);
            });
        } catch (error) {
            console.error("Error al cargar productos para administración:", error);
        }
    }

    // Enviar formulario (Crear o Actualizar)
    formProducto.addEventListener("submit", async (e) => {
        e.preventDefault();

        const idProducto = document.getElementById("idProducto").value;
        const datosProducto = {
            Nombre_Producto: document.getElementById("Nombre_Producto").value,
            descripcion_producto: document.getElementById("descripcion_producto").value,
            Precio_Producto: parseFloat(document.getElementById("Precio_Producto").value),
            Stock_Producto: parseInt(document.getElementById("Stock_Producto").value),
            Categoria_idCategoria: parseInt(document.getElementById("Categoria_idCategoria").value),
            imagen: document.getElementById("imagen").value || "images/default.jpg"
        };

        const url = idProducto ? `http://localhost:3000/api/admin/productos/${idProducto}` : "http://localhost:3000/api/admin/productos";
        const metodo = idProducto ? "PUT" : "POST";

        try {
            const respuesta = await fetch(url, {
                method: metodo,
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(datosProducto)
            });

            const resultado = await respuesta.json();
            if (resultado.exito) {
                alert(resultado.mensaje);
                formProducto.reset();
                document.getElementById("idProducto").value = "";
                btnSubmitText.textContent = "Guardar Producto";
                cargarProductosAdmin();
            } else {
                alert("Error: " + resultado.mensaje);
            }
        } catch (error) {
            console.error("Error en la petición:", error);
            alert("No se pudo conectar con el servidor backend.");
        }
    });

    // Cargar inventario inicial al abrir la página
    cargarProductosAdmin();
});

// Funciones globales para la tabla
window.prepararEdicion = function(prod) {
    document.getElementById("idProducto").value = prod.idProducto;
    document.getElementById("Nombre_Producto").value = prod.Nombre_Producto;
    document.getElementById("descripcion_producto").value = prod.descripcion_producto;
    document.getElementById("Precio_Producto").value = prod.Precio_Producto;
    document.getElementById("Stock_Producto").value = prod.Stock_Producto;
    document.getElementById("Categoria_idCategoria").value = prod.Categoria_idCategoria;
    document.getElementById("imagen").value = prod.imagen || "";
    document.getElementById("btn-submit-text").textContent = "Actualizar Producto";
    window.scrollTo({ top: 0, behavior: 'smooth' });
};

window.eliminarProducto = async function(id) {
    if (!confirm("¿Estás segura de que deseas eliminar este producto de la base de datos?")) return;

    try {
        const respuesta = await fetch(`http://localhost:3000/api/admin/productos/${id}`, {
            method: "DELETE"
        });
        const resultado = await respuesta.json();

        if (resultado.exito) {
            alert(resultado.mensaje);
            location.reload();
        } else {
            alert("Error al eliminar: " + resultado.mensaje);
        }
    } catch (error) {
        console.error("Error de red al eliminar:", error);
    }
};