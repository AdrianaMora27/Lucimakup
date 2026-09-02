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
                // Se usan exactamente los nombres de los setters de tu clase Producto.java
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
}