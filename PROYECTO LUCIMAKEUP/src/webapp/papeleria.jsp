<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Papelería - Lucimakeup</title>
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
            background-color: var(--rosa-fuerte, #ff69b4);
            font-size: 1.6rem;
            line-height: 1.5;
            margin: 0;
        }

        p { 
            font-size: 1.8rem;
            font-family: Arial, Helvetica, sans-serif;
            color: var(--negro, #000);
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
            color: var(--oscuro, #333);
            font-family: var(--fuentePrincipal, sans-serif);
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
            background-color: var(--Blanco-crema, #fffdd0);
            padding: 1rem 0;
            margin-top: 4rem;
        }

        .footer__texto { 
            text-align: center;
            font-family: var(--fuentePrincipal, sans-serif);
            font-size: 2.2rem;
        }

        /** NAVEGACION **/
        .navegacion { 
            background-color: var(--Blanco-crema, #fffdd0);
            padding: 1rem 0;
            display: flex;
            justify-content: center; 
            gap: 2rem;
            flex-wrap: wrap;
        }

        .navegacion__enlace {
            font-family: var(--fuentePrincipal, sans-serif);
            color: var(--negro, #000);
            font-size: 2.5rem;
        }

        .navegacion__enlace:hover {
            color: var(--morado, #800080);
        }

        /** SUBCATEGORIAS **/
        .subcategoria__titulo { 
            font-family: var(--fuentePrincipal, sans-serif);
            color: var(--morado, #800080);
            font-size: 2.4rem;
            text-align: left;
            margin: 3rem 0 1.5rem 0;
            border-bottom: .2rem solid var(--rosa-claro, #ffb6c1);
            padding-bottom: .5rem;
        }

        /** GRID DE PRODUCTOS **/
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
            background-color: var(--Blanco-crema, #fffdd0);
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

        /* Ajuste de imagen para evitar deformaciones */
        .tarjeta-producto__imagen img { 
            height: 22rem;
            object-fit: cover;
            background-color: var(--Rosa-sutil, #ffe4e1);
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
            font-family: var(--fuentePrincipal, sans-serif);
            font-size: 2rem;
            color: var(--oscuro, #333);
            margin-bottom: 1.5rem;
        }

        .tarjeta-producto__boton { 
            display: inline-block;
            background-color: var(--primario, #ffc0cb);
            color: var(--negro, #000);
            font-family: var(--fuentePrincipal, sans-serif);
            font-size: 1.6rem;
            padding: 1rem 2rem;
            border-radius: .5rem;
            transition: background-color .3s ease, transform .2s ease;
            text-transform: uppercase;
        }

        .tarjeta-producto__boton:hover { 
            background-color: var(--secundario-oscuro, #800080);
            color: var(--blanco, #fff);
            transform: scale(1.03);
        }

    </style>
</head>

<body>
    <header class="header">
        <a href="indexstore.html">
            <img class="header__logo" src="img/logolucistore.png" alt="Logotipo">
        </a>
    </header>

    <nav class="navegacion">
        <a class="navegacion__enlace" href="categorias.html">Catálogo</a>
        <a class="navegacion__enlace" href="Nosotros.html">Nosotros</a>
    </nav>

    <main class="contenedor">
        <h1>Papelería</h1>

        <!-- SUBCATEGORIA: ESCRITORIO Y ESCRITURA -->
        <h2 class="subcategoria__titulo">Escritorio y escritura</h2>
        <div class="grid-productos">
        
            <!-- PRODUCTO 101 -->
            <div class="tarjeta-producto" data-id="101">
                <a href="productos.html?id=101" class="tarjeta-producto__imagen">
                    <img src="img/lapicerosDiseños.jpeg" alt="Lapicero con diseño">
                </a>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Lapicero con diseño</h3>
                    <a href="productos.html?id=101" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div>

            <!-- PRODUCTO 102 -->
            <div class="tarjeta-producto" data-id="102">
                <a href="productos.html?id=102" class="tarjeta-producto__imagen">
                    <img src="img/lapizMina.jpeg" alt="Lápiz porta mina">
                </a>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Lápiz porta mina</h3>
                    <a href="productos.html?id=102" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div>

            <!-- PRODUCTO 103 -->
            <div class="tarjeta-producto" data-id="103">
                <a href="productos.html?id=103" class="tarjeta-producto__imagen">
                    <img src="img/cartuchera.jpeg" alt="Cartuchera con diseño">
                </a>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Cartuchera con diseño</h3>
                    <a href="productos.html?id=103" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div>

            <!-- PRODUCTO 104 -->
            <div class="tarjeta-producto" data-id="104">
                <a href="productos.html?id=104" class="tarjeta-producto__imagen">
                    <img src="img/resaltadores.jpeg" alt="Resaltadores con diseño">
                </a>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Resaltadores con diseño</h3>
                    <a href="productos.html?id=104" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div>
        
        </div>

        <!-- SUBCATEGORIA: CUADERNOS -->
        <h2 class="subcategoria__titulo">Cuadernos</h2>
        <div class="grid-productos">

            <!-- PRODUCTO 105 -->
            <div class="tarjeta-producto" data-id="105">
                <a href="productos.html?id=105" class="tarjeta-producto__imagen">
                    <img src="img/cuadernos.jpeg" alt="Cuadernos surtidos">
                </a>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Cuadernos surtidos</h3>
                    <a href="productos.html?id=105" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div>

            <!-- PRODUCTO 106 -->
            <div class="tarjeta-producto" data-id="106">
                <a href="productos.html?id=106" class="tarjeta-producto__imagen">
                    <img src="img/carpeta.jpeg" alt="Carpeta plástica">
                </a>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Carpeta plástica</h3>
                    <a href="productos.html?id=106" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div>

            <!-- PRODUCTO 107 -->
            <div class="tarjeta-producto" data-id="107">
                <a href="productos.html?id=107" class="tarjeta-producto__imagen">
                    <img src="img/cuadernoZootopia.jpeg" alt="Cuaderno Zootopia">
                </a>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Cuaderno Zootopia</h3>
                    <a href="productos.html?id=107" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div>

            <!-- PRODUCTO 108 -->
            <div class="tarjeta-producto" data-id="108">
                <a href="productos.html?id=108" class="tarjeta-producto__imagen">
                    <img src="img/block.jpeg" alt="Block iris">
                </a>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Block iris</h3>
                    <a href="productos.html?id=108" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div>

        </div>

        <!-- SUBCATEGORIA: ACCESORIOS Y ESTILO -->
        <h2 class="subcategoria__titulo">Accesorios y estilo</h2>
        <div class="grid-productos">

            <!-- PRODUCTO 109 -->
            <div class="tarjeta-producto" data-id="109">
                <a href="productos.html?id=109" class="tarjeta-producto__imagen">
                    <img src="img/morrales.jpeg" alt="Morral unisex">
                </a>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Morral unisex</h3>
                    <a href="productos.html?id=109" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div>
            
            <!-- PRODUCTO 110 -->
            <div class="tarjeta-producto" data-id="110">
                <a href="productos.html?id=110" class="tarjeta-producto__imagen">
                    <img src="img/llavero.jpeg" alt="Llavero surtido">
                </a>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Llavero surtido</h3>
                    <a href="productos.html?id=110" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div>

            <!-- PRODUCTO 111 -->
            <div class="tarjeta-producto" data-id="111">
                <a href="productos.html?id=111" class="tarjeta-producto__imagen">
                    <img src="img/llaveroGato.jpeg" alt="Llavero gato">
                </a>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Llavero gato</h3>
                    <a href="productos.html?id=111" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div>

        </div>

    </main>

    <footer class="footer">
        <p class="footer__texto">Frontend store Lucimakeup - Todos los derechos reservados</p>
    </footer>

    <!-- Scripts de la tienda -->
    <script src="JS/productos.js"></script>
    <script src="JS/detalleproducto.js"></script>
    <script src="JS/carrito.js"></script>

</body>
</html>