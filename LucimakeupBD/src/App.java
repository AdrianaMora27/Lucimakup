public class App {
    public static void main(String[] args) {
        ProductoDAO dao = new ProductoDAO();

        System.out.println("=== PRUEBA DE FUNCIONALIDADES CRUD LUCIMAKEUP STORE ===");

        // 1. Mostrar estado inicial
        dao.listarProductos();

        // 2. Insertar un nuevo producto
        System.out.println("\n--- probando INSERCIÓN ---");
        dao.insertarProducto("Tónico Facial", "Tónico hidratante de agua de rosas", 15000.00, 40, 2);
        dao.listarProductos();

        // 3. Actualizar stock
        System.out.println("\n--- probando ACTUALIZACIÓN ---");
        dao.actualizarStock(1, 45); // Cambia stock del Brillo Gloss
        dao.listarProductos();

        // 4. Eliminar un registro
        System.out.println("\n--- probando ELIMINACIÓN ---");
        dao.eliminarProducto(3); // Elimina la Vela con aroma
        dao.listarProductos();
    }
}