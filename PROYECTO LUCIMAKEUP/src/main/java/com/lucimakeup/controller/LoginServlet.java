package com.lucimakeup.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet de control para autenticar las credenciales de acceso de los usuarios.
 * Recibe peticiones HTTP POST desde el formulario de inicio de sesión.
 * 
 * @author Adriana Marcela Mora Rincón
 * @version 1.0
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * Procesa las peticiones POST del formulario de autenticación.
     * 
     * @param request Objeto HttpServletRequest con los parámetros del cliente.
     * @param response Objeto HttpServletResponse para enviar la respuesta o redirección.
     * @throws ServletException Si ocurre un error interno en el Servlet.
     * @throws IOException Si ocurre un error de entrada/salida durante la redirección.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String correo = request.getParameter("correo");
        String password = request.getParameter("password");

        // Lógica de validación básica de campos
        if (correo != null && !correo.trim().isEmpty() && password != null && !password.trim().isEmpty()) {
            // Autenticación correcta -> Redirige al catálogo/inicio
            response.sendRedirect("index.jsp");
        } else {
            // Fallo en la autenticación -> Retorna al login con parámetro de error
            response.sendRedirect("login.jsp?error=true");
        }
    }
}