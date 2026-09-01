
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalle de Producto - Lucimakeup</title>
    <link rel="stylesheet" href="css/normalize.css"> 
    <link href="https://fonts.googleapis.com/css2?family=Akt:wght@100..900&family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&family=Krub:ital,wght@0,200;0,300;0,400;0,500;0,600;0,700;1,200;1,300;1,400;1,500;1,600;1,700&family=Montserrat:ital,wght@0,100..900;1,100..900&family=Roboto+Condensed:ital,wght@0,100..900;1,100..900&family=Staatliches&display=swap" rel="stylesheet">

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
        --secundario-oscuro: rgb(255,287,2);
        --negro: #000;
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
    }

    .contenedor { 
        max-width: 120rem;
        margin: 0 auto;
        padding: 2rem;
    }

    /* HEADER */
    .header { 
        display: flex;
        justify-content: center;
    }

    .header__logo { 
        margin: 3rem 0;
    }

    /* NAVEGACIÓN */
    .navegacion { 
        background-color: var(--Blanco-crema);
        padding: 1rem 0;
        display: flex;
        justify-content: center;
        gap: 2rem;
    }

    .navegacion__enlace { 
        font-family: var(--fuentePrincipal);
        color: var(--negro);
        font-size: 2.5rem;
        text-decoration: none;
    }

    .navegacion__enlace:hover {
        color: var(--morado);
    }

    /* CONTENEDOR DEL DETALLE DEL PRODUCTO */
    .detalle-producto { 
        background-color: var(--Blanco-crema);
        border-radius: 1rem;
        padding: 3rem;
        margin-top: 3rem;
        display: grid;
        grid-template-columns: repeat(1, 1fr);
        gap: 4rem;
        box-shadow: 0px 5px 15px rgba(0,0,0,0.1);
    }

    @media (min-width: 768px) {
        .detalle-producto { 
            grid-template-columns: repeat(2, 1fr);
        }
    }

    .detalle-producto__imagen img { 
        width: 100%;
        border-radius: 1rem;
        object-fit: cover;
        box-shadow: 0px 4px 8px rgba(0,0,0,0.05);
    }

    .detalle-producto__info { 
        display: flex;
        flex-direction: column;
        justify-content: center; /* Corregido typo */
    }

    .detalle-producto__nombre { 
        font-family: var(--fuentePrincipal);
        font-size: 3.8rem;
        color: var(--oscuro);
        text-align: left;
        margin: 0 0 1rem 0;
    }

    .detalle-producto__precio { 
        font-size: 2.8rem;
        font-weight: bold;
        color: var(--morado);
        margin-bottom: 2rem;
    }

    .detalle-producto__descripcion { 
        font-size: 1.6rem;
        color: var(--oscuro);
        line-height: 1.8;
        margin-bottom: 3rem;
    }

    .formulario-cantidad {
        display: flex;
        gap: 1.5rem;
        align-items: center;
        margin-bottom: 2rem;
    }

    .formulario-cantidad__campo {
        padding: 1rem;
        font-size: 1.8rem;
        width: 8rem;
        border: 1px solid var(--gris);
        border-radius: 0.5rem;
    }

    /* BOTÓN AÑADIR AL CARRITO */
    .boton { 
        background-color: var(--primario);
        color: var(--negro);
        font-family: var(--fuentePrincipal);
        font-size: 2.2rem;
        padding: 1.5rem;
        border: none;
        border-radius: 0.5rem;
        cursor: pointer;
        text-transform: uppercase;
        transition: background-color 0.3s ease, transform 0.2s ease;
        text-align: center;
        width: 100%;
    }   

    .boton:hover {
        background-color: var(--morado);
        color: var(--blanco);
        transform: scale(1.02);
    }

    .footer {
        text-align: center;
        color: var(--blanco);
        margin-top: 4rem;
    }
</style>
</head>

<body>

    <header class="header">
        <a href="index.html">
            <img class="header__logo" src="img/logolucistore.png" alt="Logotipo LuciMakeup">
        </a>
    </header>

    <!-- Barra de navegación completa -->
    <nav class="navegacion">
        <a class="navegacion__enlace" href="index.html">Inicio</a>
        <a class="navegacion__enlace" href="categorias.html">Categorías</a>
        <a class="navegacion__enlace" href="cuidadoPersonal.html">Cuidado Personal</a>
        <a class="navegacion__enlace" href="hogar.html">Hogar y Estilo de Vida</a>
        <a class="navegacion__enlace" href="papeleria.html">Papelería</a>
        <a class="navegacion__enlace" href="Nosotros.html">Nosotros</a>
    </nav>

    <main class="contenedor">
        <!--MAQUETADO ESTATICO VISIBLE POR DEFECTO-->
    
    
        <div id="detalle-producto" class="detalle-producto">
            <div class="detalle-producto__imagen">
                <img src="img/cremaPeinar.jpeg" alt="crema para peinar">
            </div>

            <div class="detalle-producto__info">
                <h1 class="detalle-producto__nombre">Crema para peinar</h1>
                <p class="detalle-producto__precio">$45.000 COP</p>
                <p class="detalle-producto__descripcion">Crema para peinar marca Anyeluz, ideal para todo tipo de cabello
                    Con delicioso aroma a coco </p>

                    <!--FORMULARIO POST HACIA EL SERVLET DEL CARRITO-->

                <form action="CarritoServlet" method="POST">
                    <input type="hidden" name="productoId" value="101">
                    <div class="formulario-cantidad">
                        <label for="cantidad" style="font-size: 1.8rem; font-weight: bold;">Cantidad</label>
                        <input class="formualrio-cantidad__campo" type="number" id="cantidad" name="cantidad" min="1" value="1">

                    </div>

                    <button type="submit" class="boton">Añadir al carrito</button>
                </form>
               
            </div>
        </div>
    </main>

    <footer class="footer">
        <p class="footer__texto">Tienda Virtual LuciMakeup - Todos los derechos reservados &copy;</p>
    </footer>

    <!-- Scripts obligatorios en este orden exacto -->
    <script src="JS/productos.js"></script>
    <script src="JS/detalleProducto.js"></script>
    <script src="JS/carrito.js"></script>
</body>
</html>