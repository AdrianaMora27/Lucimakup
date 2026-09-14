<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hogar y Decoración - Lucimakeup</title>
    
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
            --negro: #000;
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

        p { 
            font-size: 1.8rem;
            font-family: Arial, Helvetica, sans-serif;
            color: var(--negro);
        }

        a { 
            text-decoration: none;
        }

        img { 
            width: 100%;
            display: block;
        }

        .contenedor { 
            max-width: 120rem;
            margin: 0 auto;
            width: 90%;
            padding: 0;
        }

        .sombra {
            box-shadow: 0px 5px 15px 0px rgba(0,0,0,0.15);
            background-color: var(--Blanco-crema);
            padding: 3rem;
            border-radius: 2rem;
            margin-bottom: 3rem;
            margin-top: 3rem;
        }

        h1, h2, h3 { 
            text-align: center;
            color: var(--oscuro);
            font-family: var(--fuentePrincipal);
        }

        h1 { font-size: 4rem; }
        h2 { font-size: 3.2rem; }
        h3 { font-size: 2.4rem; }

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
           SUBCATEGORÍAS Y PRODUCTOS
           ========================================== */
        .subcategoria__titulo { 
            font-family: var(--fuentePrincipal);
            color: var(--morado);
            font-size: 2.4rem;
            text-align: left;
            margin: 3rem 0 1.5rem 0;
            border-bottom: .2rem solid var(--rosa-claro);
            padding-bottom: .5rem;
        }

        .grid-productos { 
            display: grid;
            grid-template-columns: repeat(1, 1fr);
            gap: 3rem;
            margin-bottom: 3rem;
            align-items: stretch;
        }

        @media (min-width: 768px) {
            .grid-productos { 
                grid-template-columns: repeat(3, 1fr);
            }
        }

        .tarjeta-producto { 
            background-color: var(--blanco);
            border-radius: 1rem;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: transform .3s ease;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(255, 182, 193, 0.5);
        }

        .tarjeta-producto:hover {
            transform: translateY(-.5rem);
        }

        .tarjeta-producto__imagen img { 
            height: 22rem;
            object-fit: cover;
            background-color: var(--rosa-claro);
        }

        .tarjeta-producto__info { 
            padding: 1.5rem;
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            flex-grow: 1;
        }

        .tarjeta-producto__nombre { 
            font-family: var(--fuentePrincipal);
            font-size: 2rem;
            color: var(--oscuro);
            margin-bottom: 1.5rem;
        }

        .tarjeta-producto__boton { 
            display: inline-block;
            background-color: var(--primario);
            color: var(--oscuro);
            font-family: var(--fuentePrincipal);
            font-size: 1.6rem;
            padding: 1rem 2rem;
            border-radius: .5rem;
            transition: background-color .3s ease, transform .2s ease;
            text-transform: uppercase;
        }

        .tarjeta-producto__boton:hover { 
            background-color: var(--rojo-oscuro);
            color: var(--blanco);
            transform: scale(1.03);
        }

        /* ==========================================
           PIE DE PÁGINA
           ========================================== */
        .footer {
            background-color: rgba(255, 255, 255, 0.4);
            padding: 3rem 0;
            margin-top: 4rem;
            border-top: 1px solid var(--rosa-claro);
        }

        .footer__texto { 
            text-align: center;
            font-family: var(--fuentePrincipal);
            font-size: 2rem;
            color: var(--oscuro);
            margin: 0;
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
            <a href="<c:url value='/index.jsp#contacto'/>">Contacto</a>
        </nav>
    </div>

    <!-- CONTENIDO PRINCIPAL -->
    <main class="contenedor sombra">
        <h1>Hogar y Decoración</h1>

        <!-- SUBCATEGORIA: DECORACIÓN -->
        <h2 class="subcategoria__titulo">Decoración</h2>
        <div class="grid-productos">
        
            <!-- PRODUCTO 301 -->
            <div class="tarjeta-producto" data-id="301">
                <a href="<c:url value='/producto.jsp?id=301'/>" class="tarjeta-producto__imagen">
                    <img src="<c:url value='/img/cojinesEstampados.jpeg'/>" alt="Cojines estampados">
                </a>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Cojines estampados</h3>
                    <a href="<c:url value='/producto.jsp?id=301'/>" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div>

            <!-- PRODUCTO 302 -->
            <div class="tarjeta-producto" data-id="302">
                <a href="<c:url value='/producto.jsp?id=302'/>" class="tarjeta-producto__imagen">
                    <img src="<c:url value='/img/espejoconDiseño.jpeg'/>" alt="Espejo con diseño">
                </a>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Espejo con diseño</h3>
                    <a href="<c:url value='/producto.jsp?id=302'/>" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div>

            <!-- PRODUCTO 303 -->
            <div class="tarjeta-producto" data-id="303">
                <a href="<c:url value='/producto.jsp?id=303'/>" class="tarjeta-producto__imagen">
                    <img src="<c:url value='/img/soportePC.jpeg'/>" alt="Soporte para computador portátil">
                </a>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Soporte para computador portátil</h3>
                    <a href="<c:url value='/producto.jsp?id=303'/>" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div>
        </div>

        <!-- SUBCATEGORIA: AROMAS Y VELAS -->
        <h2 class="subcategoria__titulo">Aromas y Velas</h2>
        <div class="grid-productos">

            <!-- PRODUCTO 304 -->
            <div class="tarjeta-producto" data-id="304">
                <a href="<c:url value='/producto.jsp?id=304'/>" class="tarjeta-producto__imagen">
                    <img src="<c:url value='/img/difusorAroma.jpeg'/>" alt="Difusor de aroma electrónico">
                </a>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Difusor de aroma electrónico</h3>
                    <a href="<c:url value='/producto.jsp?id=304'/>" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div>

            <!-- PRODUCTO 305 -->
            <div class="tarjeta-producto" data-id="305">
                <a href="<c:url value='/producto.jsp?id=305'/>" class="tarjeta-producto__imagen">
                    <img src="<c:url value='/img/velaAromatica.jpeg'/>" alt="Vela con aroma">
                </a>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Vela con aroma</h3>
                    <a href="<c:url value='/producto.jsp?id=305'/>" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div>

            <!-- PRODUCTO 306 -->
            <div class="tarjeta-producto" data-id="306">
                <a href="<c:url value='/producto.jsp?id=306'/>" class="tarjeta-producto__imagen">
                    <img src="<c:url value='/img/aceiteEscencial.jpeg'/>" alt="Aceite esencial Lavanda">
                </a>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Aceite esencial Lavanda</h3>
                    <a href="<c:url value='/producto.jsp?id=306'/>" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div>
        </div>
    </main>

    <!-- PIE DE PÁGINA -->
    <footer class="footer">
        <div class="contenedor">
            <p class="footer__texto">Frontend store Lucimakeup - Todos los derechos reservados 2026</p>
        </div>
    </footer>

    <!-- Scripts de la tienda -->
    <script src="<c:url value='/JS/productos.js'/>"></script>
    <script src="<c:url value='/JS/detalleproducto.js'/>"></script>
    <script src="<c:url value='/JS/carrito.js'/>"></script>
</body>
</html>