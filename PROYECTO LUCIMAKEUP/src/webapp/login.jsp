<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión - Lucimakeup</title>

    <!-- Framework Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Paleta de Colores Personalizada Lucimakeup Store -->
    <style>
        :root {
            --blanco: #ffffff;
            --oscuro: #212121;
            --primario: #ffc107;
            --gris: #757575;
            --rosa-claro: #ffb6c1;
            --rosa-fuerte: #ff69b4;
            --rojo-oscuro: #880e2f;
            --Gris-claro: #dfe9f3;
            --Blanco-crema: #FFF8F5;
            --Gris-arena: #F4F4F2;
            --Beige-calido: #F9F5EB;
            --Azul-lavanda: #D6E4F0;
            --Verde-menta: #E2F0D9;
            --Rosa-sutil: #FCE4EC;
            --morado: #9C27B0;
            --morado-oscuro: #89119D;
            --secundario-oscuro: rgb(255,187,2);
            --negro: #000;
        }

        body {
            background-color: var(--Rosa-sutil) !important;
            color: var(--oscuro);
            font-size: 1.6rem;
        }

        /* Redefinición de clases de Bootstrap para acoplar la identidad visual */
        .text-primary {
            color: var(--rojo-oscuro) !important;
        }

        .btn-primary {
            background-color: var(--rosa-fuerte) !important;
            border-color: var(--rosa-fuerte) !important;
            color: var(--blanco) !important;
            font-size: 1.6rem;
        }

        .btn-primary:hover {
            background-color: var(--rojo-oscuro) !important;
            border-color: var(--rojo-oscuro) !important;
        }

        .form-control:focus {
            border-color: var(--rosa-fuerte) !important;
            box-shadow: 0 0 0 0.25rem rgba(255, 105, 180, 0.25) !important;
        }
        
        .card {
            background-color: var(--Blanco-crema);
        }
    </style>
</head>
<body class="d-flex align-items-center vh-100">

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5 col-lg-4">
                <div class="card shadow-lg border-0 rounded-4">
                    <div class="card-body p-4 text-center">
                        <h2 class="fw-bold text-primary mb-2">Lucimakeup</h2>
                        <p class="text-muted mb-4" style="font-size: 1.5rem;">Ingresa tus credenciales para acceder</p>

                        <!-- Control de errores de autenticación -->
                        <% if (request.getParameter("error") != null) { %>
                            <div class="alert alert-danger py-2 small" role="alert" style="font-size: 1.4rem;">
                                Correo o contraseña incorrectos.
                            </div>
                        <% } %>

                        <!-- Formulario dirigido al controlador LoginServlet -->
                        <form action="<c:url value='/LoginServlet'/>" method="POST">
                            <div class="mb-3 text-start">
                                <label for="correo" class="form-label fw-bold" style="font-size: 1.5rem;">Correo Electrónico</label>
                                <input type="email" class="form-control" id="correo" name="correo" placeholder="ejemplo@correo.com" required>
                            </div>

                            <div class="mb-4 text-start">
                                <label for="password" class="form-label fw-bold" style="font-size: 1.5rem;">Contraseña</label>
                                <input type="password" class="form-control" id="password" name="password" placeholder="••••••••" required>
                            </div>

                            <button type="submit" class="btn btn-primary w-100 py-2 rounded-3 fw-bold">Ingresar</button>
                        </form>
                        
                        <!-- Enlace opcional de retorno a la tienda -->
                        <div class="mt-3">
                            <a href="<c:url value='/index.jsp'/>" class="text-muted small" style="font-size: 1.4rem; text-decoration: underline;">Volver a la tienda</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Framework Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>