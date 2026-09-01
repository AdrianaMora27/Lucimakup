package com.lucimakeup.config;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {
    private static final String URL = "jdbc:mysql://localhost:3306/lucimakeup_db?useSSL=false&serverTimezone=UTC";
    private static final String USUARIO = "root";
    private static final String PASSWORD = ""; // En XAMPP la contraseña por defecto va vacía

    public static Connection obtenerConexion() {
        Connection conexion = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conexion = DriverManager.getConnection(URL, USUARIO, PASSWORD);
            System.out.println("¡Conexión exitosa a la base de datos lucimakeup_db!");
        } catch (ClassNotFoundException e) {
            System.out.println("Error: Driver de MySQL no encontrado -> " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("Error de conexión a MySQL -> " + e.getMessage());
        }
        return conexion;
    }
}