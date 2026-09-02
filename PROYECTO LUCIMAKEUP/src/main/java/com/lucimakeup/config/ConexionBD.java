package com.lucimakeup.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Clase de configuración para la gestión de conexiones a la base de datos MySQL.
 * Implementa el patrón JDBC para establecer y cerrar conexiones de forma segura.
 * 
 * @author Adriana Marcela Mora Rincón
 * @version 1.0
 */
public class ConexionBD {

    private static final String URL = "jdbc:mysql://localhost:3306/lucimakeup_db?useSSL=false&serverTimezone=UTC";
    private static final String USUARIO = "root";
    private static final String PASSWORD = ""; // En XAMPP la contraseña por defecto va vacía
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    /**
     * Obtiene una conexión activa a la base de datos MySQL.
     * 
     * @return Connection Objeto de conexión a la base de datos.
     * @throws SQLException Si ocurre un error al conectar.
     */
    public static Connection obtenerConexion() throws SQLException {
        Connection conexion = null;
        try {
            Class.forName(DRIVER);
            conexion = DriverManager.getConnection(URL, USUARIO, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.err.println("Error: Driver JDBC no encontrado: " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("Error al conectar a lucimakeup_db: " + e.getMessage());
            throw e;
        }
        return conexion;
    }

    /**
     * Cierra de forma segura una conexión abierta.
     * 
     * @param conexion Objeto Connection que se desea cerrar.
     */
    public static void cerrarConexion(Connection conexion) {
        if (conexion != null) {
            try {
                conexion.close();
            } catch (SQLException e) {
                System.err.println("Error al cerrar la conexión: " + e.getMessage());
            }
        }
    }
}