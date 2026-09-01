package com.lucimakeup.controller;

public class TestLoginServlet {

    public static void main(String[] args) {
        System.out.println("=== PRUEBA DE LOGICA DE LOGINSERVLET ===");

        // Prueba 1: Datos válidos
        probarLogin("usuario@correo.com", "12345");

        // Prueba 2: Campos vacíos
        probarLogin("", "");
    }

    private static void probarLogin(String correo, String password) {
        System.out.println("\nProbando credenciales -> Correo: '" + correo + "' | Clave: '" + password + "'");
        
        // Simulación de la regla de negocio exacta del Servlet:
        if (correo != null && !correo.isEmpty() && password != null && !password.isEmpty()) {
            System.out.println("-> Resultado: [ÉXITO] Redirigiendo a index.jsp");
        } else {
            System.out.println("-> Resultado: [ERROR] Redirigiendo a login.jsp?error=true");
        }
    }
}