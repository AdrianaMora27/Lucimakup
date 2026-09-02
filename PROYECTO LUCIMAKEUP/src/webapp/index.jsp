<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lucimakeup Store - Catálogo</title>
    <!-- Framework Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

    <!-- Menú de Navegación -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#">Lucimakeup Store</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link active" href="index.jsp">Inicio</a></li>
                    <li class="nav-item"><a class="nav-link" href="login.jsp">Cerrar Sesión</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Banner Promocional -->
    <div class="bg-primary text-white text-center py-5 mb-5">
        <div class="container">
            <h1 class="display-4 fw-bold">Catálogo de Productos</h1>
            <p class="lead">Descubre la mejor variedad en belleza y cuidado personal</p>
        </div>
    </div>

    <!-- Muestra de Productos -->
    <div class="container mb-5">
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card h-100 shadow-sm border-0">
                    <div class="card-body">
                        <h5 class="card-title fw-bold">Tónico Facial</h5>
                        <p class="card-text text-muted">Hidrata y refresca la piel de tu rostro diariamente.</p>
                        <div class="d-flex justify-content-between align-items-center mt-3">
                            <span class="h5 mb-0 text-primary fw-bold">$15,000</span>
                            <span class="badge bg-success">Stock: 40</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card h-100 shadow-sm border-0">
                    <div class="card-body">
                        <h5 class="card-title fw-bold">Labial Humectante</h5>
                        <p class="card-text text-muted">Color de larga duración con textura suave.</p>
                        <div class="d-flex justify-content-between align-items-center mt-3">
                            <span class="h5 mb-0 text-primary fw-bold">$12,000</span>
                            <span class="badge bg-success">Stock: 25</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Framework Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/bootstrap.bundle.min.js"></script>
</body>
</html>