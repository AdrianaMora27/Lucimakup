package com.lucimakeup.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Recibe los datos ingresados en el formulario de login.jsp
        String correo = request.getParameter("correo");
        String password = request.getParameter("password");

        // Validación temporal de prueba
        if (correo != null && !correo.isEmpty() && password != null && !password.isEmpty()) {
            // Si hay datos, simula inicio de sesión exitoso y redirige al inicio
            response.sendRedirect("index.jsp");
        } else {
            // Si faltan datos, redirige de nuevo al login con un parámetro de error
            response.sendRedirect("login.jsp?error=true");
        }
    }
}