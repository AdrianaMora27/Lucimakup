<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tienda Virtual Lucimakeup</title>
    
    <!-- Archivo de Normalización CSS -->
    <link rel="stylesheet" href="<c:url value='/Normalize.css'/>"> 
    
    <!-- Fuentes de Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&family=Krub:ital,wght@0,200;0,300;0,400;0,500;0,600;0,700;1,200;1,300;1,400;1,500;1,600;1,700&family=Roboto+Condensed:wght@100..900&family=Staatliches&display=swap" rel="stylesheet">

    <style>
        /* ==========================================
           VARIABLES DE DISEÑO Y PALETA DE COLORES
           ========================================== */
        :root {
            --blanco: #ffffff;
            --oscuro: #212121;
            --primario: #ffc107;
            --gris: #757575;
            --rosa-claro: #ffb6c1;
            --rosa-fuerte: #ff69b4;
            --rojo-oscuro: #880e2f;
            --Blanco-crema: #FFF8F5;
            --morado: #9C27B0;
            --secundario-oscuro: rgb(255,187,2);
            --fuentePrincipal: "Staatliches", sans-serif;
            --fuente-principal-tamano: 3.8rem;
        }

        /* ==========================================
           CONFIGURACIÓN GLOBAL Y RESET
           ========================================== */
        html {
            font-size: 62.5%;
            box-sizing: border-box;
        }

        *, *:before, *:after {
            box-sizing: inherit;
        }

        body {
            font-size: 1.6rem;
            font-family: Verdana, Geneva, Tahoma, sans-serif;
            background-image: linear-gradient(to top, var(--rosa-fuerte) 0%, var(--blanco) 100%);
            margin: 0;
            min-height: 100vh;
        }

        .contenedor { 
            max-width: 120rem;
            margin: 0 auto;
            width: 90%;
        }

        .sombra {
            box-shadow: 0px 5px 15px 0px rgba(0,0,0,0.15);
            background-color: var(--Blanco-crema);
            padding: 3rem;
            border-radius: 2rem;
            margin-bottom: 3rem;
        }

        /* ==========================================
           CABECERA Y CARRITO DE COMPRAS
           ========================================== */
        .header-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.5rem 2rem;
            max-width: 120rem;
            margin: 0 auto;
        }

        .titulo {
            text-align: center;
            font-size: var(--fuente-principal-tamano);
            color: var(--oscuro);
            text-transform: uppercase;
            font-family: var(--fuentePrincipal);
            font-weight: 700;
            margin: 0;
        }

        .titulo span {
            font-size: 2rem;
            color: var(--oscuro);
            font-family: var(--fuentePrincipal);
        }

        .carrito-container {
            position: relative;
            cursor: pointer;
            display: flex;
            align-items: center;
            text-decoration: none;
            color: var(--oscuro);
        }

        .carrito-icon {
            width: 3.5rem;
            height: 3.5rem;
            transition: transform 0.2s ease;
        }

        .carrito-container:hover .carrito-icon {
            transform: scale(1.1);
        }

        .carrito-badge {
            position: absolute;
            top: -5px;
            right: -8px;
            background-color: var(--rojo-oscuro);
            color: var(--blanco);
            font-size: 1.2rem;
            font-weight: bold;
            border-radius: 50%;
            padding: 0.2rem 0.6rem;
        }

        /* ==========================================
           BARRA DE NAVEGACIÓN
           ========================================== */
        .nav-bg { 
            background-color: var(--rosa-claro);
        }
            
        .navegacion-principal {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 2rem;
            flex-wrap: wrap;
        }

        .navegacion-principal a, .dropdown-btn {
            display: block;
            text-align: center;
            padding: 1.2rem 2.5rem;
            background-color: var(--rosa-claro);
            color: var(--oscuro);
            text-decoration: none;
            font-size: 1.8rem;
            font-family: var(--fuentePrincipal);
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .navegacion-principal a:hover, .dropdown:hover .dropdown-btn {
            background-color: var(--blanco);
            color: var(--rojo-oscuro);
        }

        /* Menú Desplegable Categorías */
        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: var(--blanco);
            min-width: 20rem;
            box-shadow: 0px 8px 16px rgba(0,0,0,0.15);
            z-index: 10;
            border-radius: 0 0 0.8rem 0.8rem;
            overflow: hidden;
        }

        .dropdown-content a {
            color: var(--oscuro);
            padding: 1.2rem 1.6rem;
            text-align: left;
            font-size: 1.6rem;
            font-weight: normal;
            background-color: var(--blanco);
            border-bottom: 1px solid var(--rosa-claro);
            font-family: Arial, sans-serif;
        }

        .dropdown-content a:hover {
            background-color: var(--rosa-claro);
            color: var(--oscuro);
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        /* ==========================================
           BANNER HERO
           ========================================== */
        .lucimakeupimg { 
            background-image: url('<c:url value="/img/Lucimakeup.jpg"/>');
            background-repeat: no-repeat;
            background-size: cover;
            background-position: center center;
            height: 380px;
            position: relative;
            margin-bottom: 2rem;
        }

        .contenido-lucimakeupimg {
            position: absolute;
            background-color: rgba(0, 0, 0, 0.4);
            height: 100%;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: flex-end;
            padding-right: 5rem;
        }

        .contenido-lucimakeupimg h2.titulo {
            color: var(--blanco);
            font-size: 3.8rem;
            margin: 0;
        }

        /* ==========================================
           GRID DE SERVICIOS / CATEGORÍAS PRINCIPALES
           ========================================== */
        .Servicios {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-bottom: 4rem;
        }

        .servicio-card {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-decoration: none;
            color: inherit;
            padding: 1.5rem;
            border-radius: 1rem;
            transition: transform 0.3s ease, background-color 0.3s ease;
        }

        .servicio-card:hover {
            background-color: rgba(255, 255, 255, 0.5);
            transform: translateY(-.3rem);
        }

        .servicio-card h3 {
            color: var(--oscuro);
            font-family: var(--fuentePrincipal);
            margin-bottom: 1rem;
            font-size: 2.2rem;
        }

        .servicio-card p { 
            line-height: 1.6;
            text-align: center;
            font-size: 1.5rem;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        .servicio-card .iconos {
            height: 13rem;
            width: 13rem;
            background-color: var(--primario);
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 1.5rem auto;
            transition: transform 0.3s ease;
        }

        .servicio-card:hover .iconos {
            transform: scale(1.08);
        }

        /* ==========================================
           FORMULARIO DE CONTACTO
           ========================================== */
        .formulario {
            background-color: var(--gris);
            width: min(65rem, 100%);
            margin: 2rem auto 0 auto;
            padding: 2.5rem;
            border-radius: 1rem;
        }

        .formulario fieldset { 
            border: none;
            padding: 0;
            margin: 0;
        }

        .formulario legend { 
            text-align: center;
            font-size: 2rem;
            text-transform: uppercase;
            font-family: var(--fuentePrincipal);
            margin-bottom: 2rem;
            color: var(--primario);
        }

        .contenedor-campos {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
        }

        .campo:nth-child(3), .campo:nth-child(4) {
            grid-column: 1 / 3;
        }

        .campo label { 
            color: var(--blanco);
            font-weight: bold;
            margin-bottom: .8rem;
            display: block;
            font-size: 1.5rem;
        }

        .input-text { 
            width: 100%;
            border: none;
            padding: 1.2rem;
            border-radius: .5rem;
            font-size: 1.4rem;
            outline: none;
        }

        .campo textarea.input-text {
            height: 15rem;
            resize: vertical;
        }

        .boton {
            background-color: var(--rosa-claro);
            color: var(--oscuro);
            padding: 1rem 3.5rem;
            margin-top: 2rem;
            font-size: 1.8rem;
            font-family: var(--fuentePrincipal);
            text-transform: uppercase;
            border-radius: .5rem;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .boton:hover {
            background-color: var(--rosa-fuerte);
            color: var(--blanco);
        }

        /* ==========================================
           PIE DE PÁGINA Y REDES SOCIALES
           ========================================== */
        .footer {
            background-color: rgba(255, 255, 255, 0.4);
            padding: 3rem 0;
            margin-top: 4rem;
            border-top: 1px solid var(--rosa-claro);
        }

        .footer-contenido {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 1.5rem;
        }

        .redes-sociales {
            display: flex;
            gap: 2.5rem;
            align-items: center;
            flex-wrap: wrap;
            justify-content: center;
        }

        .red-link {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            text-decoration: none;
            color: var(--oscuro);
            font-weight: bold;
            font-size: 1.6rem;
            transition: color 0.3s ease;
        }

        .red-link:hover {
            color: var(--rojo-oscuro);
        }

        .red-icon {
            width: 2.4rem;
            height: 2.4rem;
            fill: currentColor;
        }

        .footer-derechos {
            font-size: 1.4rem;
            color: var(--oscuro);
            margin: 0;
            font-family: var(--fuentePrincipal);
        }
    </style>
</head>

<body>
    <!-- CABECERA INSTITUCIONAL Y CARRITO -->
    <header class="header-top">
        <div style="width: 3.5rem;"></div>
        <h1 class="titulo">Lucimakeup<span>Store</span></h1>
        
        <!-- Enlace al Carrito de Compras -->
        <a href="<c:url value='/carrito.jsp'/>" class="carrito-container" title="Ver carrito de compras">
            <svg class="carrito-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <circle cx="9" cy="21" r="1"></circle>
                <circle cx="20" cy="21" r="1"></circle>
                <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
            </svg>
            <span class="carrito-badge">0</span>
        </a>
    </header>

    <!-- BARRA DE NAVEGACIÓN PRINCIPAL -->
    <div class="nav-bg">
        <nav class="navegacion-principal contenedor">
            <a href="<c:url value='/index.jsp'/>">Inicio</a>
            
            <!-- Menú Desplegable Categorías -->
            <div class="dropdown">
                <button class="dropdown-btn">Categorías &#9662;</button>
                <div class="dropdown-content">
                    <a href="<c:url value='/CategoriasServlet?cat=maquillaje'/>">Maquillaje</a>
                    <a href="<c:url value='/cuidadopersonal.jsp'/>">Cuidado Personal</a>
                    <a href="<c:url value='/hogar.jsp'/>">Hogar</a>
                    <a href="<c:url value='/papeleria.jsp'/>">Papelería</a>
                </div>
            </div>

            <a href="<c:url value='/login.jsp'/>">Ingresar</a>
            <a href="#contacto">Contacto</a>
        </nav>
    </div>

    <!-- BANNER HERO -->
    <section class="lucimakeupimg">
        <div class="contenido-lucimakeupimg">
            <h2 class="titulo">Bienvenidos</h2>
        </div>
    </section>

    <!-- CONTENIDO PRINCIPAL / SERVICIOS -->
    <main class="contenedor sombra">
        <h2 style="text-align: center; font-size: 2.8rem; margin-bottom: 2rem; font-family: var(--fuentePrincipal);">Nuestros Servicios</h2>

        <div class="Servicios">
            <!-- Tarjeta Cuidado Personal -->
            <a href="<c:url value='/cuidadopersonal.jsp'/>" class="servicio-card">
                <h3>Cuidado personal</h3>
                <div class="iconos">
                    <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M9 3m0 1a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v1a1 1 0 0 1 -1 1h-4a1 1 0 0 1 -1 -1z" />
                        <path d="M10 6v.98c0 .877 -.634 1.626 -1.5 1.77c-.866 .144 -1.5 .893 -1.5 1.77v8.48a2 2 0 0 0 2 2h6a2 2 0 0 0 2 -2v-8.48c0 -.877 -.634 -1.626 -1.5 -1.77a1.795 1.795 0 0 1 -1.5 -1.77v-.98" />
                        <path d="M7 12h10" />
                        <path d="M7 18h10" />
                        <path d="M11 15h2" />
                    </svg>
                </div>
                <p>Cuidarte es el mejor regalo que puedes hacerte. Descubre productos pensados en ti para realzar tu belleza natural.</p>
            </a>

            <!-- Tarjeta Hogar -->
            <a href="<c:url value='/hogar.jsp'/>" class="servicio-card">
                <h3>Hogar</h3>
                <div class="iconos">
                    <svg xmlns="http://www.w3.org/2000/svg" width="55" height="55" viewBox="0 0 24 24" fill="currentColor">
                        <path d="M3.903 4.008l.183 -.008h10.828a2.08 2.08 0 0 1 2.086 2.077v.923h1.5c1.917 0 3.5 1.477 3.5 3.333v2.334c0 1.856 -1.583 3.333 -3.5 3.333h-1.663a5.33 5.33 0 0 1 -5.17 4h-4.334c-2.944 0 -5.333 -2.375 -5.333 -5.308v-8.618a2.08 2.08 0 0 1 1.903 -2.066m13.097 9.992h1.5c.843 0 1.5 -.613 1.5 -1.333v-2.334c0 -.72 -.657 -1.333 -1.5 -1.333h-1.5z" />
                    </svg>
                </div>
                <p>Un hogar bonito empieza con los detalles correctos.</p>
            </a>

            <!-- Tarjeta Papelería -->
            <a href="<c:url value='/papeleria.jsp'/>" class="servicio-card">
                <h3>Papelería</h3>
                <div class="iconos">
                    <svg xmlns="http://www.w3.org/2000/svg" width="75" height="75" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M17 3l4 4l-14 14l-4 -4z" />
                        <path d="M16 7l-1.5 -1.5" />
                        <path d="M13 10l-1.5 -1.5" />
                        <path d="M10 13l-1.5 -1.5" />
                        <path d="M7 16l-1.5 -1.5" />
                    </svg>
                </div>
                <p>Herramientas diseñadas para organizar tus días e inspirar tus ideas.</p>
            </a>
        </div>

        <!-- FORMULARIO DE CONTACTO -->
        <section id="contacto">
            <h2 style="text-align: center; font-size: 2.8rem; font-family: var(--fuentePrincipal);">Escríbenos</h2>

            <form class="formulario" action="<c:url value='/ContactoServlet'/>" method="POST">
                <fieldset>
                    <legend>Contáctanos</legend>
                    
                    <div class="contenedor-campos">
                        <div class="campo">
                            <label for="nombre">Nombre</label>
                            <input class="input-text" type="text" id="nombre" name="nombre" placeholder="Tu nombre" required>
                        </div>
                        
                        <div class="campo">
                            <label for="telefono">Teléfono</label>
                            <input class="input-text" type="tel" id="telefono" name="telefono" placeholder="Tu número">
                        </div>
                        
                        <div class="campo">
                            <label for="email">Correo Electrónico</label>
                            <input class="input-text" type="email" id="email" name="email" placeholder="Correo electrónico" required>
                        </div>
                        
                        <div class="campo">
                            <label for="mensaje">Mensaje</label>
                            <textarea class="input-text" id="mensaje" name="mensaje" required></textarea>
                        </div>
                    </div>

                    <div>
                        <input class="boton" type="submit" value="Enviar">
                    </div>
                </fieldset>
            </form>
        </section>
    </main>

    <!-- PIE DE PÁGINA Y REDES SOCIALES -->
    <footer class="footer">
        <div class="contenedor footer-contenido">
            <div class="redes-sociales">
                <!-- Instagram -->
                <a href="https://www.instagram.com/lucimakeup23" target="_blank" class="red-link">
                    <svg class="red-icon" viewBox="0 0 24 24">
                        <path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z"/>
                    </svg>
                    <span>@lucimakeup23</span>
                </a>

                <!-- TikTok -->
                <a href="https://www.tiktok.com/@lucimakeup23" target="_blank" class="red-link">
                    <svg class="red-icon" viewBox="0 0 24 24">
                        <path d="M12.525.02c1.31-.02 2.61-.01 3.91-.02.08 1.53.63 3.09 1.75 4.17 1.12 1.11 2.7 1.62 4.24 1.79v4.03c-1.44-.05-2.89-.35-4.2-.97-.57-.26-1.1-.59-1.62-.93-.01 2.92.01 5.84-.02 8.75-.08 1.4-.54 2.79-1.35 3.94-1.31 1.92-3.58 3.17-5.91 3.21-1.43.08-2.86-.31-4.08-1.03-2.02-1.19-3.44-3.37-3.65-5.71-.02-.5-.03-1-.01-1.49.18-1.9 1.12-3.72 2.58-4.96 1.66-1.44 3.98-2.13 6.15-1.72.02 1.48-.04 2.96-.04 4.44-.99-.32-2.15-.23-3.02.37-.82.56-1.31 1.54-1.32 2.53-.01 1.08.57 2.13 1.49 2.68.96.58 2.22.61 3.19.06.85-.47 1.41-1.38 1.45-2.36.08-3.71.03-7.43.04-11.15.01-1.7.01-3.41.01-5.11z"/>
                    </svg>
                    <span>@lucimakeup23</span>
                </a>
            </div>

            <p class="footer-derechos">Todos los derechos reservados Lucimakeup &copy; 2026</p>
        </div>
    </footer>

    <!-- Script Principal de la Tienda -->
    <script src="<c:url value='/main.js'/>"></script>
</body>
</html>