<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lucimakeup Store - Iniciar Sesión</title>
    <!-- Framework Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center vh-100">

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

                            <button type="submit" class="btn btn-primary w-100 py-2 rounded-3">Ingresar</button>
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