<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carrito de Compras - Lucimakeup Store</title>
    <link rel="stylesheet" href="<c:url value='/css/normalize.css'/>">
    <link href="https://fonts.googleapis.com/css2?family=Staatliches&display=swap" rel="stylesheet">

    <style>
    :root { 
        --blanco: #ffffff;
        --oscuro: #212121;
        --primario: #ffc107;
        --gris: #757575;
        --rosa-claro: #ffb6c1;
        --rosa-fuerte: #ff69b4;
        --Blanco-crema: #FFF8F5;
        --morado: #9C27B0;
        --morado-oscuro: #89119D;
        --negro: #000;
        --rojo-alerta: #d32f2f;

        --fuentePrincipal: "Staatliches", sans-serif;
    }

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
        font-family: Arial, Helvetica, sans-serif;
        margin: 0;
    }

    .contenedor { 
        max-width: 120rem;
        margin: 0 auto;
        padding: 0 2rem;
    }

    h1 { 
        text-align: center;
        color: var(--oscuro);
        font-family: var(--fuentePrincipal);
        font-size: 4rem;
        margin-top: 2rem;
    }

    /**HEADER**/

    .header {
        display: flex;
        justify-content: center;
    }

    .header__logo { 
        margin: 3rem 0;
        max-width: 25rem;
    }

    /*NAVEGACION*/
    .navegacion {
        background-color: var(--Blanco-crema);
        padding: 1.5rem 0;
        display: flex;
        justify-content: center;
        gap: 3rem;
    }

    .navegacion__enlace { 
        font-family: var(--fuentePrincipal);
        color: var(--negro);
        font-size: 1.5rem;
        text-decoration: none;
        transition: color 0.3s ease;
    }

    .navegacion__enlace:hover { 
        color: var(--morado);
    }

    /*CARRITO GRID**/

    .carrito-grid { 
        display: grid;
        grid-template-columns: 1fr;
        gap: 3rem;
        margin-top: 3rem;
    }

    @media (min-width: 992px) {
        .carrito-grid { 
            grid-template-columns: 2fr 1fr;
        }
    }

    /**TABLA Y LISTA DE PRODUCTOS**/

    .carrito-contenido { 
        background-color: var(--Blanco-crema);
        border-radius: 1rem;
        padding: 2.5rem;
        box-shadow: 0px 5px 10px rgba(0,0,0,0.1);
    }

    .carrito-item {
        display: grid;
        grid-template-columns: 8rem 1fr auto;
        gap: 2rem;
        align-items: center;
        padding: 1.5rem 0;
        border-bottom: 1px solid var(--rosa-claro);
    }

    .carrito-item:last-child {
        border-bottom: none;
    }

    .carrito-item__imagen { 
        width: 100%;
        border-radius: 0.5rem;
        height: 8rem;
        display: block;
        object-fit: cover;
    }

    .carrito-item__detalles { 
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
    }

    .carrito-item__nombre { 
        font-family: var(--fuentePrincipal);
        font-size: 2.2rem;
        margin: 0;
        color: var(--oscuro);
    }

    .carrito-item__precio { 
        font-size: 1.8rem;
        color: var(--morado);
        font-weight: bold;
    }

    .carrito-item__controles { 
        display: flex;
        flex-direction: column;
        align-items: flex-end;
        gap: 1rem;
    }

    .carrito-item__cantidad { 
        width: 6rem;
        padding: 0.5rem;
        text-align: center;
        font-size: 1.6rem;
        border: 1px solid var(--rosa-claro);
        border-radius: 0.5rem;
    }

    .carrito-item__eliminar {
        background: none;
        border: none;
        color: var(--rojo-alerta);
        font-size: 1.4rem;
        cursor: pointer;
        text-decoration: underline;
    }

    /**RESUMEN DEL PEDIDO**/

    .resumen-pedido { 
        background-color: var(--Blanco-crema);
        border-radius: 1rem;
        padding: 2.5rem;
        box-shadow: 0px 5px 10px rgba(0,0,0,0.1);
        height: fit-content;
    }

    .resumen-pedido__titulo { 
        font-family: var(--fuentePrincipal);
        font-size: 2.8rem;
        margin-top: 0;
        color: var(--morado-oscuro);
        text-align: center;
    }

    .resumen-linea { 
        display: flex;
        justify-content: space-between;
        font-size: 1.8rem;
        margin-bottom: 1.5rem;
    }

    .resumen-linea--total { 
        font-size: 2.2rem;
        font-weight: bold;
        border-top: 2px solid var(--rosa-claro);
        padding-top: 1.5rem;
        color: var(--oscuro);
    }

    .boton-checkout { 
        display: block;
        width: 100%;
        background-color: var(--primario);
        color: var(--negro);
        font-family: var(--fuentePrincipal);
        font-size: 2.2rem;
        padding: 1.5rem;
        border: none;
        border-radius: 0.5rem;
        cursor: pointer;
        text-align: center;
        text-decoration: none;
        text-transform: uppercase;
        margin-top: 2rem;
        transition: background-color 0.3s ease;
    }

    .boton-checkout:hover { 
        background-color: var(--morado);
        color: var(--blanco);
    }

    /*FOOTER**/

    .footer { 
        background-color: var(--Blanco-crema);
        padding: 1.5rem 0;
        margin-top: 4rem;
    }

    .footer__texto { 
        text-align: center;
        font-family: var(--fuentePrincipal);
        font-size: 2.2rem;
        margin: 0;
    }
    </style>
</head>

<body>
    <header class="header">
        <a href="<c:url value='/index.jsp'/>">
            <img class="header__logo" src="<c:url value='/img/logolucistore.png'/>" alt="Logotipo Lucimakeup">
        </a>
    </header>

    <nav class="navegacion">
        <a class="navegacion__enlace" href="<c:url value='/categorias.jsp'/>">Categorías</a>
        <a class="navegacion__enlace" href="<c:url value='/cuidadoPersonal.jsp'/>">Cuidado Personal</a>
        <a class="navegacion__enlace" href="<c:url value='/hogar.jsp'/>">Estilo y Vida</a>
        <a class="navegacion__enlace" href="<c:url value='/papeleria.jsp'/>">Papelería</a>
        <a class="navegacion__enlace" href="<c:url value='/Nosotros.jsp'/>">Nosotros</a>
    </nav>

    <main class="contenedor">
        <h1>Tu carrito de compras</h1>

        <div class="carrito-grid">

            <!-- Lista de productos agregados -->
            <section class="carrito-contenido">

                <!-- Producto 1 -->
                <div class="carrito-item">
                    <img src="<c:url value='/img/brilloGloss.jpeg'/>" alt="Brillo Gloss" class="carrito-item__imagen">
                    <div class="carrito-item__detalles">
                        <h3 class="carrito-item__nombre">Brillo Gloss</h3>
                        <span class="carrito-item__precio">$12.000 COP</span>
                    </div>
                    <div class="carrito-item__controles">
                        <input type="number" value="2" min="1" class="carrito-item__cantidad">
                        <button class="carrito-item__eliminar">Eliminar</button>
                    </div>
                </div>

                <!-- Producto 2 -->
                <div class="carrito-item">
                    <img src="<c:url value='/img/block.jpeg'/>" alt="block" class="carrito-item__imagen">
                    <div class="carrito-item__detalles">
                        <h3 class="carrito-item__nombre">Block 100 hojas</h3>
                        <span class="carrito-item__precio">$8.000 COP</span>
                    </div>
                    <div class="carrito-item__controles">
                        <input type="number" value="2" min="1" class="carrito-item__cantidad">
                        <button class="carrito-item__eliminar">Eliminar</button>
                    </div>
                </div>

                <!-- Producto 3 -->
                <div class="carrito-item">
                    <img src="<c:url value='/img/velaAromatica.jpeg'/>" alt="velaAromatica" class="carrito-item__imagen">
                    <div class="carrito-item__detalles">
                        <h3 class="carrito-item__nombre">Vela con aroma</h3>
                        <span class="carrito-item__precio">$10.000 COP</span>
                    </div>
                    <div class="carrito-item__controles">
                        <input type="number" value="2" min="1" class="carrito-item__cantidad">
                        <button class="carrito-item__eliminar">Eliminar</button>
                    </div>
                </div>

            </section>

            <!-- Resumen Financiero -->
            <aside class="resumen-pedido">
                <h2 class="resumen-pedido__titulo">Resumen de la compra</h2>

                <div class="resumen-linea">
                    <span>Subtotal:</span>
                    <span>$30.000 COP</span>
                </div>

                <div class="resumen-linea">
                    <span>Envío:</span>
                    <span>$8.000 COP</span>
                </div>

                <div class="resumen-linea resumen-linea--total">
                    <span>Total:</span>
                    <span>$38.000 COP</span>
                </div>

                <!-- Redirección correcta usando contextPath -->
                <a href="${pageContext.request.contextPath}/checkout.jsp" class="boton-checkout">Pagar</a>
            </aside>

        </div>
    </main>

    <footer class="footer">
        <p class="footer__texto">Frontend store Lucimakeup - Todos los derechos reservados</p>
    </footer>

    <script src="<c:url value='/JS/carrito.js'/>"></script>
</body>
</html>