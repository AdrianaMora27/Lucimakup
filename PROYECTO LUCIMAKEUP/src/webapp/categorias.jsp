<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catálogo - Lucimakeup Store</title>
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

        /* GLOBALES */
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

        /** HEADER **/
        .header { 
            display: flex;
            justify-content: center;
        }

        .header__logo { 
            margin: 3rem 0;
        }

        /** FOOTER **/
        .footer { 
            background-color: var(--Blanco-crema);
            padding: 1rem 0;
            margin-top: 4rem;
        }

        .footer__texto { 
            text-align: center;
            font-family: var(--fuentePrincipal);
            font-size: 2.2rem;
        }

        /** NAVEGACION **/
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
        }

        .navegacion__enlace:hover {
            color: var(--morado);
        }

        /** VITRINA DE CATEGORIAS **/
        .vitrina-categorias { 
            display: grid;
            grid-template-columns: repeat(1, 1fr);
            gap: 3rem;
            margin: 4rem 0;
        }

        @media (min-width: 768px) {
            .vitrina-categorias { 
                grid-template-columns: repeat(3, 1fr);
            }
        }

        .tarjeta-categoria {
            position: relative;
            display: block;
            border-radius: 1.5rem;
            overflow: hidden;
            height: 35rem;
            box-shadow: 0px 5px 5px 5px rgba(0,0,0,0.1);
        }

        .tarjeta-categoria__imagen { 
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform .4s ease;
        }

        .tarjeta-categoria:hover .tarjeta-categoria__imagen {
            transform: scale(1.08);
        }

        .tarjeta-categoria__overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            background-color: rgba(0, 0, 0, 0.55);
            padding: 2rem 1rem;
            text-align: center;
        }

        .tarjeta-categoria__nombre { 
            font-family: var(--fuentePrincipal);
            color: var(--blanco);
            font-size: 2.8rem;
            margin: 0;
        }

        /** TITULOS Y SECCIONES DE PRODUCTOS **/
        .seccion-titulo {
            font-family: var(--fuentePrincipal);
            color: var(--morado);
            font-size: 2.8rem;
            text-align: left;
            margin: 4rem 0 2rem 0;
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
            box-shadow: 0px 5px 5px rgba(0, 0, 0, 0.08);
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
            margin-bottom: 1.5rem;
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
            background-color: var(--morado-oscuro);
            color: var(--blanco);
            transform: scale(1.03);
        }
    </style>
</head>

<body>
    <header class="header">
        <a href="indexstore.html">
            <img class="header__logo" src="img/logolucistore.png" alt="Logotipo Lucimakeup">
        </a>
    </header>

    <nav class="navegacion">
        <a class="navegacion__enlace" href="categorias.html">Catálogo</a>
        <a class="navegacion__enlace" href="Nosotros.html">Nosotros</a> 
    </nav>

    <main class="contenedor">
        <h1>Nuestro Catálogo</h1>
        <p style="text-align: center;">Explora nuestras categorías principales</p>

        <!-- CATEGORÍAS PRINCIPALES -->
        <div class="vitrina-categorias">
            <a href="cuidadoPersonal.html" class="tarjeta-categoria">
                <img class="tarjeta-categoria__imagen" src="img/CuidadoPersonal.jpeg" alt="Cuidado Personal">
                <div class="tarjeta-categoria__overlay">
                    <h2 class="tarjeta-categoria__nombre">Cuidado Personal</h2>
                </div>
            </a>

            <a href="hogar.html" class="tarjeta-categoria">
                <img class="tarjeta-categoria__imagen" src="img/estilo y vida.jpeg" alt="Estilo y Vida">
                <div class="tarjeta-categoria__overlay">
                    <h2 class="tarjeta-categoria__nombre">Estilo y Vida / Hogar</h2>
                </div>
            </a>

            <a href="papeleria.html" class="tarjeta-categoria">
                <img class="tarjeta-categoria__imagen" src="img/papeleria.jpeg" alt="Papelería">
                <div class="tarjeta-categoria__overlay">
                    <h2 class="tarjeta-categoria__nombre">Papelería</h2>
                </div>
            </a>
        </div>

        <!-- DESTACADOS IDENTIFICADOS CON ID -->
        <h2 class="seccion-titulo">Productos Destacados</h2>
        <div class="grid-productos">

            <!-- PRODUCTO 101 (PAPELERÍA) -->
            <div class="tarjeta-producto" data-id="101">
                <a href="productos.html?id=101" class="tarjeta-producto__imagen">
                    <img src="img/lapicerosDiseños.jpeg" alt="Lapicero con diseño">
                </a>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Lapicero con diseño</h3>
                    <a href="productos.html?id=101" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div>

            <!-- PRODUCTO 201 (CUIDADO PERSONAL) -->
            <div class="tarjeta-producto" data-id="201">
                <a href="productos.html?id=201" class="tarjeta-producto__imagen">
                    <img src="img/MascarillasHidratantes.jpeg" alt="Mascarilla Facial Bioaqua">
                </a>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Mascarilla Facial Bioaqua</h3>
                    <a href="productos.html?id=201" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div>

            <!-- PRODUCTO 301 (HOGAR / ESTILO Y VIDA) -->
            <div class="tarjeta-producto" data-id="301">
                <a href="productos.html?id=301" class="tarjeta-producto__imagen">
                    <img src="img/termo.jpg" alt="Termo térmico de acero">
                </a>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Termo térmico de acero</h3>
                    <a href="productos.html?id=301" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div>

        </div>
    </main>

    <footer class="footer">
        <p class="footer__texto">Tienda Virtual Lucimakeup - Todos los derechos reservados</p>
    </footer>

    <!-- Scripts de la tienda -->
    <script src="JS/productos.js"></script>
    <script src="JS/detalleproducto.js"></script>
    <script src="JS/carrito.js"></script>
</body>
</html>