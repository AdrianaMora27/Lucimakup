package com.lucimakeup.model;

public class App {
    public static void main(String[] args) {
        ProductoDAO dao = new ProductoDAO();

        System.out.println("=== INICIO DE PRUEBAS CRUD - LUCIMAKEUP STORE ===\n");

        // 1. LECTURA (HU-01: Listar inventario inicial)
        //System.out.println("[1] Consultando listado inicial de productos:");
        //dao.listarProductos();

        // 2. CREACIÓN (HU-02: Insertar nuevo producto de prueba)
        //System.out.println("\n[2] Insertando un nuevo producto al inventario:");
        //dao.insertarProducto("Tónico Facial", "Tónico hidratante de agua de rosas", 15000.00, 40, 2);
        
        // Verificamos listado tras la inserción
        //System.out.println("--- Listado después de insertar ---");
        //dao.listarProductos();

        // 3. ACTUALIZACIÓN (HU-02: Modificar stock de un producto existente, ej: ID 1)
        //System.out.println("\n[3] Actualizando el stock de un producto:");
        //dao.actualizarStock(1, 45); 

        // ==========================================
        // PASO 4: PROBAR LA ELIMINACIÓN (DELETE)
        // ==========================================
       
        //System.out.println("\n=== 4. PROBANDO ELIMINACIÓN DE UN PRODUCTO ===");
        //dao.eliminarProducto(3); // Borra el producto con ID 3 de prueba
        
        //System.out.println("--- Verificando listado tras eliminar ---");
        dao.listarProductos();
        

        System.out.println("\n=== FIN DE LA PRUEBA DE FUNCIONALIDAD ===");
    }
}