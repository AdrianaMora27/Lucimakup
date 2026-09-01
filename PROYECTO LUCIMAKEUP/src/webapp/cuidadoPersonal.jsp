<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cuidado personal - Lucimakeup</title>
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

        /*GLOBALES**/
        body { 
            background-color: var(--rosa-fuerte);
            font-size: 1.6rem;
            line-height: 1.5;
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
        }

        .contenedor { 
            max-width: 120rem;
            margin: 0 auto;
        }

        h1, h2, h3 { 
            text-align: center;
            color: var(--oscuro);
            font-family: var(--fuentePrincipal);
        }

        h1 { 
            font-size: 4rem;
        }
        
        h2 { 
            font-size: 3.2rem;
        }

        h3 { 
            font-size: 2.4rem;
        }

        /**HEADER**/
        .header { 
            display: flex;
            justify-content: center;
        }

        .header__logo { 
            margin: 3rem 0;
        }

        /**FOOTER**/
        .footer { 
            background-color: var(--Blanco-crema);
            padding: 1rem 0;
            margin-top: 2rem;
        }

        .footer__texto { 
            text-align: center;
            font-family: var(--fuentePrincipal);
            font-size: 2.2rem;
        }

        /**NAVEGACION**/
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

        .navegacion__enlace--activo:hover { 
            color: var(--morado);
        }

        .navegacion__enlace:hover {
            color: var(--morado);
        }

        /**SUBCATEGORIAS**/
        .subcategoria__titulo { 
            font-family: var(--fuentePrincipal);
            color: var(--morado);
            font-size: 2.4rem;
            text-align: left;
            margin: 3rem 0 1.5rem 0;
            border-bottom: .2rem solid var(--rosa-claro);
            padding-bottom: .5rem;
        }

        /**GRID DE PRODUCTOS**/
        .grid-productos { 
            display: grid;
            grid-template-columns: repeat(1, 1fr);
            gap: 3rem;
            margin-bottom: 3rem;
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
            display: block;
            transition: transform .3s ease;
            box-shadow: 0px 5px 5px 5px rgb(0,0,0,0.08);
        }

        .tarjeta-producto:hover {
            transform: translateY(-.5rem);
        }

        .tarjeta-producto__imagen { 
            height: 22rem;
            object-fit: cover;
            background-color: var(--Rosa-sutil);
        }

        .tarjeta-producto__info { 
            padding: 1.5rem;
            text-align: center;
        }

        .tarjeta-producto__nombre { 
            font-family: var(--fuentePrincipal);
            font-size: 2rem;
            color: var(--oscuro);
            margin-bottom: 1rem;
        }

        .tarjeta-producto__boton { 
            display: inline-block;
            background-color: var(--primario);
            color: var(--negro);
            font-family: var(--fuentePrincipal);
            font-size: 1.6rem;
            padding: .8rem 2rem;
            border-radius: .5rem;
            transition: background-color .3s ease;
        }

        .tarjeta-producto__boton:hover { 
            background-color: var(--secundario-oscuro);
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
        <a class="navegacion__enlace navegacion__enlace--activo" href="categorias.html">Catalogo</a>
        <a class="navegacion__enlace navegacion__enlace--activo" href="Nosotros.html">Nosotros</a>
    </nav>

    <main class="contenedor">
        <h1>Cuidado Personal</h1>

        <!--SUBCATEGORIA: CUIDADO CAPILAR-->
        <h2 class="subcategoria__titulo">Cuidado Capilar</h2>
        <div class="grid-productos">
        
            <!--PRODUCTO 301-->
            <div class="tarjeta-producto">
                <div class="tarjeta-producto__imagen">
                    <img src="img/cuidadocapilar.jpeg" alt="Acondicionador">
                </div>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Acondicionador</h3>
                    <a href="productos.html?id=301" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div> <!--FIN PRODUCTO-->

            <!--PRODUCTO 302-->
            <div class="tarjeta-producto">
                <div class="tarjeta-producto__imagen">
                    <img src="img/shampoo.jpeg" alt="shampoo">
                </div>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Shampoo Todo tipo</h3>
                    <a href="productos.html?id=302" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div> <!--FIN PRODUCTO-->

            <!--PRODUCTO 303-->
            <div class="tarjeta-producto">
                <div class="tarjeta-producto__imagen">
                    <img src="img/cremaPeinar.jpeg" alt="Crema de Peinar">
                </div>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Crema de peinar</h3>
                    <a href="productos.html?id=303" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div> <!--FIN PRODUCTO-->

        </div><!--FIN SUBCATEGORIA-->

            
        <!--SUBCATEGORIA: CUIDADO CORPORAL-->
        <h2 class="subcategoria__titulo">Cuidado corporal</h2>
        <div class="grid-productos">

            <!--PRODUCTO 304-->
            <div class="tarjeta-producto">
                <div class="tarjeta-producto__imagen">
                    <img src="img/cuidadocorporal.jpeg" alt="Cuidado corporal">
                </div>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Aceite de coco corporal</h3>
                    <a href="productos.html?id=304" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div> <!--FIN PRODUCTO-->

            <!--PRODUCTO 305-->
            <div class="tarjeta-producto">
                <div class="tarjeta-producto__imagen">
                    <img src="img/mantequilla.jpeg" alt="Mantequilla">
                </div>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Mantequilla corporal</h3>
                    <a href="productos.html?id=305" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div> <!--FIN PRODUCTO-->

            <!--PRODUCTO 306-->
            <div class="tarjeta-producto">
                <div class="tarjeta-producto__imagen">
                    <img src="img/perfumeGlitter.jpeg" alt="perfume con glitter">
                </div>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Perfume con Glitter</h3>
                    <a href="productos.html?id=306" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div> <!--FIN PRODUCTO-->

        </div> <!--FIN SUBCATEGORIA-->


        <!--SUBCATEGORIA: MAQUILLAJE / OTROS CUIDADOS-->
        <h2 class="subcategoria__titulo">Maquillaje y Rostro</h2>
        <div class="grid-productos">

            <!--PRODUCTO 307-->
            <div class="tarjeta-producto">
                <div class="tarjeta-producto__imagen">
                    <img src="img/gelcejas.jpeg" alt="Gel de cejas">
                </div>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Gel de cejas</h3>
                    <a href="productos.html?id=307" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div> <!--FIN PRODUCTO-->

            <!--PRODUCTO 308-->
            <div class="tarjeta-producto">
                <div class="tarjeta-producto__imagen">
                    <img src="img/ruborBarra.jpeg" alt="Rubor en barra">
                </div>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Rubor en barra</h3>
                    <a href="productos.html?id=308" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div> <!--FIN PRODUCTO-->

            <!--PRODUCTO 309-->
            <div class="tarjeta-producto">
                <div class="tarjeta-producto__imagen">
                    <img src="img/blushLiquido.jpeg" alt="Blush liquido">
                </div>
                <div class="tarjeta-producto__info">
                    <h3 class="tarjeta-producto__nombre">Blush Liquido</h3>
                    <a href="productos.html?id=309" class="tarjeta-producto__boton">Ver producto</a>
                </div>
            </div> <!--FIN PRODUCTO-->

        </div> <!--FIN SUBCATEGORIA-->

    </main>

    <footer class="footer">
        <p class="footer__texto">Frontend store Lucimakeup - Todos los derechos reservados</p>
    </footer>

    <script src="JS/carrito.js"></script>

</body>
</html>