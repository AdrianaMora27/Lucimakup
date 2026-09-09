<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lucimakeup Store - Iniciar Sesión</title>

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

            --fuente-principal: 3.8rem;
        }

        body {
            background-color: var(--Rosa-sutil) !important;
            color: var(--oscuro);
        }

        /* Corrección de mapeo a las variables reales */
        .text-primary {
            color: var(--rojo-oscuro) !important;
        }

        .btn-primary {
            background-color: var(--rosa-fuerte) !important;
            border-color: var(--rosa-fuerte) !important;
            color: var(--blanco) !important;
        }

        .btn-primary:hover {
            background-color: var(--rojo-oscuro) !important;
            border-color: var(--rojo-oscuro) !important;
        }

        .form-control:focus {
            border-color: var(--rosa-fuerte) !important;
            box-shadow: 0 0 0 0.25rem rgba(255, 105, 180, 0.25) !important;
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
                        <p class="text-muted mb-4">Ingresa tus credenciales para acceder</p>

                        <% if (request.getParameter("error") != null) { %>
                            <div class="alert alert-danger py-2 small" role="alert">
                                Correo o contraseña incorrectos.
                            </div>
                        <% } %>

                        <form action="LoginServlet" method="POST">
                            <div class="mb-3 text-start">
                                <label for="correo" class="form-label font-weight-bold">Correo Electrónico</label>
                                <input type="email" class="form-control" id="correo" name="correo" placeholder="ejemplo@correo.com" required>
                            </div>

                            <div class="mb-4 text-start">
                                <label for="password" class="form-label font-weight-bold">Contraseña</label>
                                <input type="password" class="form-control" id="password" name="password" placeholder="••••••••" required>
                            </div>

                            <button type="submit" class="btn btn-primary w-100 py-2 rounded-3 fw-bold">Ingresar</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Framework Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/bootstrap.bundle.min.js"></script>
</body>
</html>