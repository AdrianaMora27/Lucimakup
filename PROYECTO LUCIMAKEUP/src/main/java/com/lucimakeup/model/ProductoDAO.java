package com.lucimakeup.model;

import com.lucimakeup.config.ConexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Clase DAO (Data Access Object) para gestionar las operaciones CRUD 
 * de los productos en la tienda Lucimakeup Store.
 * 
 * @author Adriana Marcela Mora Rincón
 * @version 1.0
 */
public class ProductoDAO {

    /**
     * Consulta y retorna la lista completa de productos disponibles en el catálogo.
     * 
     * @return List<Producto> Lista de objetos Producto.
     */
    public List<Producto> listarProductos() {
        List<Producto> lista = new ArrayList<>();
        String sql = "SELECT * FROM productos";

        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Producto p = new Producto();
                p.setIdProducto(rs.getInt("id_producto"));
                p.setNombreProducto(rs.getString("nombre"));
                p.setPrecioProducto(rs.getDouble("precio"));
                p.setStockProducto(rs.getInt("stock"));
                lista.add(p);
                
                System.out.println("ID: " + p.getIdProducto() + 
                                   " | Nombre: " + p.getNombreProducto() + 
                                   " | Precio: $" + p.getPrecioProducto() + 
                                   " | Stock: " + p.getStockProducto());
            }

        } catch (SQLException e) {
            System.err.println("Error al listar productos en ProductoDAO: " + e.getMessage());
        }
        return lista;
    }

    /**
     * Inserta un nuevo producto en la base de datos.
     * 
     * @param nombre Nombre del producto.
     * @param descripcion Descripción detallada.
     * @param precio Precio unitario.
     * @param stock Cantidad disponible.
     * @param idCategoria Identificador de la categoría.
     */
    public void insertarProducto(String nombre, String descripcion, double precio, int stock, int idCategoria) {
        String sql = "INSERT INTO productos (nombre, descripcion, precio, stock, id_categoria) VALUES (?, ?, ?, ?, ?)";

        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, nombre);
            ps.setString(2, descripcion);
            ps.setDouble(3, precio);
            ps.setInt(4, stock);
            ps.setInt(5, idCategoria);

            ps.executeUpdate();
            System.out.println("-> Producto insertado correctamente.");

        } catch (SQLException e) {
            System.err.println("Error al insertar producto: " + e.getMessage());
        }
    }

    /**
     * Actualiza el stock disponible de un producto por su ID.
     * 
     * @param idProducto Identificador del producto.
     * @param nuevoStock Nueva cantidad de stock.
     */
    public void actualizarStock(int idProducto, int nuevoStock) {
        String sql = "UPDATE productos SET stock = ? WHERE id_producto = ?";

        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, nuevoStock);
            ps.setInt(2, idProducto);

            ps.executeUpdate();
            System.out.println("-> Stock actualizado correctamente para ID " + idProducto);

        } catch (SQLException e) {
            System.err.println("Error al actualizar stock: " + e.getMessage());
        }
    }

    /**
     * Elimina un producto de la base de datos según su ID.
     * 
     * @param idProducto Identificador del producto a eliminar.
     */
    public void eliminarProducto(int idProducto) {
        String sql = "DELETE FROM productos WHERE id_producto = ?";

        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idProducto);

            ps.executeUpdate();
            System.out.println("-> Producto con ID " + idProducto + " eliminado.");

        } catch (SQLException e) {
            System.err.println("Error al eliminar producto: " + e.getMessage());
        }
    }
}