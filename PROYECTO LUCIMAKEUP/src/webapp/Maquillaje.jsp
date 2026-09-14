<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Maquillaje - Lucimakeup</title>
    <link rel="stylesheet" href="<c:url value='/css/normalize.css'/>"> 
    <link href="https://fonts.googleapis.com/css2?family=Akt:wght@100..900&family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&family=Krub:ital,wght@0,200;0,300;0,400;0,500;0,600;0,700;1,200;1,300;1,400;1,500;1,600;1,700&family=Montserrat:ital,wght@0,100..900;1,100..900&family=Roboto+Condensed:ital,wght@0,100..900;1,100..900&family=Staatliches&display=swap" rel="stylesheet">

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
            --fuentePrincipal: "Staatliches", sans-serif;
        }

        /* ==========================================
            CONFIGURACIÓN GLOBAL Y RESET
            ========================================== */
        html { 
            box-sizing: border-box;
            font-size: 62.5%;
        }
        
        *, *:before, *::after {
            box-sizing: inherit;
        }

        body { 
            background-color: var(--rosa-fuerte);
            font-size: 1.6rem;
            line-height: 1.5;
            margin: 0;
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
            padding: 0 2rem;
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
            ESTILOS DE CABECERA Y NAVEGACIÓN
            ========================================== */
        .header { 
            display: flex;
            justify-content: center;
        }

        .header__logo { 
            margin: 3rem 0;
        }

        .navegacion { 
            background-color: var(--Blanco-crema);
            padding: 1rem 0;
            display: flex;
            justify-content: center; 
            gap: 2rem;
            flex-wrap: wrap;
        }

        .navegacion__enlace {
            font-family: var(--fuentePrincipal);
            color: var(--negro);
            font-size: 2.5rem;
        }

        .navegacion__enlace:hover {
            color: var(--morado);
        }

        /* ==========================================
            SECCIONES Y TARJETAS DE PRODUCTOS DINÁMICOS
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
            background-color: var(--Blanco-crema);
            border-radius: 1rem;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: transform .3s ease;
            box-shadow: 0px 5px 10px rgba(0,0,0,0.08);
        }

        .tarjeta-producto:hover {
            transform: translateY(-.5rem);
        }

        .tarjeta-producto__imagen img { 
            height: 22rem;
            object-fit: cover;
            background-color: var(--Rosa-sutil);
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
            margin-bottom: .5rem;
        }

        .tarjeta-producto__precio {
            font-family: var(--fuentePrincipal);
            font-size: 2.2rem;
            color: var(--morado-oscuro);
            margin: 0.5rem 0 1.5rem 0;
        }

        .tarjeta-producto__boton { 
            display: inline-block;
            background-color: var(--primario);
            color: var(--negro);
            font-family: var(--fuentePrincipal);
            font-size: 1.6rem;
            padding: 1rem 2rem;
            border-radius: .5rem;
            transition: background-color .3s ease, transform .2s ease;
            text-transform: uppercase;
        }

        .tarjeta-producto__boton:hover { 
            background-color: var(--secundario-oscuro);
            color: var(--blanco);
            transform: scale(1.03);
        }

        /* ==========================================
            PIE DE PÁGINA (FOOTER)
            ========================================== */
        .footer { 
            background-color: var(--Blanco-crema);
            padding: 1.5rem 0;
            margin-top: 4rem;
        }

        .footer__texto { 
            text-align: center;
            font-family: var(--fuentePrincipal);
            font-size: 2.2rem;
        }
    </style>
</head>

<body>
    <!-- CABECERA INSTITUCIONAL -->
    <header class="header">
        <a href="<c:url value='/index.jsp'/>">
            <img class="header__logo" src="<c:url value='/img/logolucistore.png'/>" alt="Logotipo Lucimakeup">
        </a>
    </header>

    <!-- NAVEGACIÓN PRINCIPAL -->
    <nav class="navegacion">
        <a class="navegacion__enlace" href="<c:url value='/index.jsp'/>">Inicio</a>
        <a class="navegacion__enlace" href="<c:url value='/CategoriasServlet'/>">Catálogo</a>
        <a class="navegacion__enlace" href="<c:url value='/nosotros.jsp'/>">Nosotros</a>
    </nav>

    <!-- CONTENEDOR PRINCIPAL: MAQUILLAJE -->
    <main class="contenedor">
        <h1>Maquillaje</h1>

        <!-- RECORRIDO DINÁMICO DE SUBCATEGORÍAS DESDE EL SERVLET (JSTL) -->
        <c:forEach var="subcategoria" items="${listaSubcategorias}">
            <h2 class="subcategoria__titulo">${subcategoria.nombre}</h2>
            
            <div class="grid-productos">
                <!-- RECORRIDO DINÁMICO DE PRODUCTOS ASOCIADOS -->
                <c:forEach var="producto" items="${subcategoria.productos}">
                    <div class="tarjeta-producto">
                        <a href="<c:url value='/ProductoController?id=${producto.idProducto}'/>" class="tarjeta-producto__imagen">
                            <img src="<c:url value='/img/${producto.imagen}'/>" alt="${producto.nombre}">
                        </a>
                        <div class="tarjeta-producto__info">
                            <h3 class="tarjeta-producto__nombre">${producto.nombre}</h3>
                            <p class="tarjeta-producto__precio">$${producto.precio}</p>
                            <a href="<c:url value='/ProductoController?id=${producto.idProducto}'/>" class="tarjeta-producto__boton">Ver producto</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:forEach>
    </main>

    <!-- PIE DE PÁGINA -->
    <footer class="footer">
        <p class="footer__texto">Tienda Virtual Lucimakeup - Todos los derechos reservados &copy; 2026</p>
    </footer>

    <!-- SCRIPTS DE LA APLICACIÓN -->
    <script src="<c:url value='/JS/carrito.js'/>"></script>
</body>
</html>