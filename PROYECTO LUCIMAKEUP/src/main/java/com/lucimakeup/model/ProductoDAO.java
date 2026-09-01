package com.lucimakeup.model;

import com.lucimakeup.config.ConexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ProductoDAO {

    // 1. CONSULTAR (READ)
    public void listarProductos() {
        String sql = "SELECT * FROM Producto";
        try (Connection con = ConexionBD.obtenerConexion();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            System.out.println("\n--- CATÁLOGO DE PRODUCTOS LUCIMAKEUP ---");
            while (rs.next()) {
                System.out.println("ID: " + rs.getInt("idProducto") +
                                   " | Nombre: " + rs.getString("Nombre_Producto") +
                                   " | Precio: $" + rs.getDouble("Precio_Producto") +
                                   " | Stock: " + rs.getInt("Stock_Producto"));
            }
        } catch (SQLException e) {
            System.out.println("Error al consultar: " + e.getMessage());
        }
    }

    // 2. INSERTAR (CREATE)
    public void insertarProducto(String nombre, String descripcion, double precio, int stock, int idCategoria) {
        String sql = "INSERT INTO Producto (Nombre_Producto, descripcion_producto, Precio_Producto, Stock_Producto, Categoria_idCategoria) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, nombre);
            ps.setString(2, descripcion);
            ps.setDouble(3, precio);
            ps.setInt(4, stock);
            ps.setInt(5, idCategoria);
            ps.executeUpdate();
            System.out.println("✔ Producto '" + nombre + "' insertado con éxito.");
        } catch (SQLException e) {
            System.out.println("Error al insertar: " + e.getMessage());
        }
    }

    // 3. ACTUALIZAR (UPDATE)
    public void actualizarStock(int idProducto, int nuevoStock) {
        String sql = "UPDATE Producto SET Stock_Producto = ? WHERE idProducto = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, nuevoStock);
            ps.setInt(2, idProducto);
            ps.executeUpdate();
            System.out.println("✔ Stock del producto ID " + idProducto + " actualizado a " + nuevoStock + " unidades.");
        } catch (SQLException e) {
            System.out.println("Error al actualizar: " + e.getMessage());
        }
    }

    // 4. ELIMINAR (DELETE)
    public void eliminarProducto(int idProducto) {
        String sql = "DELETE FROM Producto WHERE idProducto = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idProducto);
            ps.executeUpdate();
            System.out.println("✔ Producto ID " + idProducto + " eliminado correctamente.");
        } catch (SQLException e) {
            System.out.println("Error al eliminar: " + e.getMessage());
        }
    }
}