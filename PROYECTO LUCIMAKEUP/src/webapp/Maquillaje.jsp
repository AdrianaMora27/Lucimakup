<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tienda Virtual LuciMakeup</title>
    <link rel="stylesheet" href="css/normalize.css"> 
    <link href="https://fonts.googleapis.com/css2?family=Akt:wght@100..900&family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&family=Krub:ital,wght@0,200;0,300;0,400;0,500;0,600;0,700;1,200;1,300;1,400;1,500;1,600;1,700&family=Roboto+Condensed:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">

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

            --fuente-principal: 3.8rem;
        }

        /* Globales **/
        html {
            font-size: 62.5%;
            box-sizing: border-box;
            scroll-snap-type: y mandatory;
        }

        *, *:before, *:after {
            box-sizing: inherit;
        }

        body {
            font-size: 16px;
            font-family: Verdana, Geneva, Tahoma, sans-serif;
            background-image: linear-gradient(to top, var(--rosa-fuerte) 0%, var(--blanco) 100%);
            margin: 0;
        }

        .contenedor { 
            max-width: 120rem;
            margin: 0 auto;
            padding: 0 2rem;
        }

        .boton {
            background-color: var(--rosa-claro);
            color: var(--oscuro);
            padding: 1rem 3rem;
            margin: 1rem auto;
            font-size: 2rem;
            text-decoration: none;
            text-transform: uppercase;
            font-weight: bold;
            border-radius: .5rem;
            width: auto;
            display: inline-block;
            text-align: center;
            border: none;
            transition: background-color .3s ease;
        }

        .boton:hover {
            cursor: pointer;
            background-color: var(--rosa-fuerte);
            color: var(--blanco);
        }

        @media (min-width: 768px) {
            .sombra {
                box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1);
                background-color: var(--Blanco-crema);
                padding: 3rem;
                border-radius: 2rem;
            }

            .servicio,
            .navegacion-principal { 
                scroll-snap-align: flex-start;
                scroll-snap-stop: always;
            }
        }

        /* Tipografia **/
        h1 { font-size: 3.8rem; }
        h2 { font-size: 2.8rem; }
        h3 { font-size: 1.8rem; text-decoration: none; }
        
        h1, h2, h3 { 
            text-align: center;
        }

        /* Titulos **/
        .titulo {
            text-align: center;
            font-size: var(--fuente-principal);
            color: var(--oscuro);
            text-transform: uppercase;
            font-family: "Krub", sans-serif;
            font-weight: 700;
            font-style: italic;
        }

        h2.titulo {
            text-align: center;
            color: var(--oscuro);
            text-transform: capitalize;
            font-size: 3.8rem;
        }

        .titulo span {
            font-size: 2rem;
            color: var(--oscuro);
        }

        /* Navegacion principal **/
        .nav-bg { 
            background-color: var(--rosa-claro);
        }
            
        .navegacion-principal {
            display: flex;
            flex-direction: column;
        }
        
        @media (min-width: 768px) {
            .navegacion-principal {
                flex-direction: row;
                justify-content: space-around;
                align-items: center;
            }
        }

        .navegacion-principal a {
            display: block;
            text-align: center;
            padding: 1.2rem;
            background-color: var(--rosa-claro);
            color: var(--oscuro);
            text-decoration: none;
            font-size: 1.8rem;
            font-weight: bold;
            transition: background-color .3s ease, color .3s ease;
        }

        .navegacion-principal a:hover {
            background-color: var(--blanco);
            color: var(--rojo-oscuro);
        }

        /* Lucimakeup banner **/
        .lucimakeupimg { 
            background-image: url('img/Lucimakeup.jpg');
            background-repeat: no-repeat;
            background-size: cover;
            background-position: center center;
            height: 400px;
            position: relative;
            margin-bottom: 3rem;
        }

        .contenido-lucimakeupimg {
            position: absolute;
            background-color: rgba(0, 0, 0, 0.6);
            height: 100%;
            width: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: var(--blanco);
        }

        .contenido-lucimakeupimg .titulo {
            color: var(--blanco);
            margin-bottom: 1rem;
        }

        /* Servicios / Categorias **/
        .Servicios {
            display: grid;
            grid-template-columns: 1fr;
            gap: 2rem;
        }

        @media (min-width: 768px) {
            .Servicios {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        .servicio {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-decoration: none;
            padding: 2rem;
            border-radius: 1rem;
            transition: transform .3s ease;
        }

        .servicio:hover {
            transform: translateY(-.5rem);
        }

        .servicio a {
            text-decoration: none;
            color: var(--oscuro);
        }

        .servicio h3 {
            color: var(--oscuro);
            font-weight: bold;
            margin-top: 1rem;
        }

        .servicio p { 
            line-height: 1.6;
            text-align: center;
            font-size: 1.5rem;
        }

        .servicio .iconos {
            height: 14rem;
            width: 14rem;
            background-color: var(--primario);
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.1);
        }

        /* Contacto **/
        .formulario {
            background-color: var(--gris);
            width: min(60rem, 100%);
            margin: 3rem auto 0 auto;
            padding: 2rem;
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
            font-weight: 700;
            margin-bottom: 2rem;
            color: var(--primario);
        }

        .contenedor-campos { 
            display: grid;
            grid-template-columns: 1fr;
            gap: 1rem;
        }

        @media (min-width: 768px) {
            .contenedor-campos { 
                grid-template-columns: repeat(2, 1fr);
            }

            .campo:nth-child(3), 
            .campo:nth-child(4) {
                grid-column: 1 / 3;
            }
        }

        .campo { 
            margin-bottom: 1rem;
        }

        .campo label { 
            color: var(--blanco);
            font-weight: bold;
            margin-bottom: .5rem;
            display: block;
            font-size: 1.4rem;
        }

        .campo textarea {
            height: 15rem;
            resize: vertical;
        }

        .input-text { 
            width: 100%;
            border: none;
            padding: 1.2rem;
            border-radius: .5rem;
            font-size: 1.5rem;
        }

        /* Footer **/
        .footer {
            text-align: center;
            padding: 2rem 0;
            margin-top: 4rem;
            background-color: var(--Blanco-crema);
            font-weight: bold;
        }
    </style>
</head>

<body>
    <header>
        <h1 class="titulo">LuciMakeup<span>Store</span></h1>
    </header>

    <div class="nav-bg">
        <nav class="navegacion-principal contenedor">
            <a href="index.html">Inicio</a>
            <a href="categorias.html">Catálogo</a>
            <a href="cuidadoPersonal.html">Cuidado Personal</a>
            <a href="hogar.html">Hogar</a>
            <a href="papeleria.html">Papelería</a>
            <a href="Nosotros.html">Nosotros</a>
            <a href="login.html">Ingresar</a>
            <a href="#contacto">Contacto</a>
        </nav>
    </div>

    <section class="lucimakeupimg">
        <div class="contenido-lucimakeupimg">
            <h2 class="titulo">Bienvenidos a LuciMakeup Store</h2>
            <p style="font-size: 1.8rem; margin-bottom: 2rem;">Encuentra los mejores productos para tu estilo y cuidado personal</p>
            <a href="categorias.html" class="boton">Ver Catálogo</a>
        </div>
    </section>

    <main class="contenedor sombra">
        <h2>Nuestras Categorías</h2>

        <div class="Servicios">
            <section class="servicio">
                <a href="cuidadoPersonal.html">
                    <div class="iconos">
                        <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M9 3m0 1a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v1a1 1 0 0 1 -1 1h-4a1 1 0 0 1 -1 -1z" />
                            <path d="M10 6v.98c0 .877 -.634 1.626 -1.5 1.77c-.866 .144 -1.5 .893 -1.5 1.77v8.48a2 2 0 0 0 2 2h6a2 2 0 0 0 2 -2v-8.48c0 -.877 -.634 -1.626 -1.5 -1.77a1.795 1.795 0 0 1 -1.5 -1.77v-.98" />
                            <path d="M7 12h10" />
                            <path d="M7 18h10" />
                            <path d="M11 15h2" />
                        </svg>
                    </div>
                    <h3>Cuidado Personal</h3>
                </a>
                <p>Cuidarte es el mejor regalo que puedes hacerte. Descubre productos pensados en ti para realzar tu belleza natural.</p>
            </section>

            <section class="servicio">
                <a href="hogar.html"> 
                    <div class="iconos">
                        <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M3.903 4.008l.183 -.008h10.828a2.08 2.08 0 0 1 2.086 2.077v.923h1.5c1.917 0 3.5 1.477 3.5 3.333v2.334c0 1.856 -1.583 3.333 -3.5 3.333h-1.663a5.33 5.33 0 0 1 -5.17 4h-4.334c-2.944 0 -5.333 -2.375 -5.333 -5.308v-8.618a2.08 2.08 0 0 1 1.903 -2.066m13.097 9.992h1.5c.843 0 1.5 -.613 1.5 -1.333v-2.334c0 -.72 -.657 -1.333 -1.5 -1.333h-1.5z" />
                        </svg>
                    </div>
                    <h3>Estilo y Vida / Hogar</h3>
                </a>
                <p>Un hogar bonito empieza con los detalles correctos. Encuentra artículos que complementen tu espacio.</p>
            </section>

            <section class="servicio">
                <a href="papeleria.html">
                    <div class="iconos">
                        <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" viewBox="0 0 24 24" fill="none" stroke="#000000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M17 3l4 4l-14 14l-4 -4z" />
                            <path d="M16 7l-1.5 -1.5" />
                            <path d="M13 10l-1.5 -1.5" />
                            <path d="M10 13l-1.5 -1.5" />
                            <path d="M7 16l-1.5 -1.5" />
                        </svg>
                    </div>
                    <h3>Papelería</h3>
                </a>
                <p>Herramientas diseñadas para organizar tus días, inspirar tus ideas y acompañar cada uno de tus proyectos.</p>
            </section>
        </div>

        <!-- FORMULARIO DE CONTACTO -->
        <section id="contacto">
            <h2 style="margin-top: 4rem;">Escríbenos</h2>

            <form class="formulario">
                <fieldset>
                    <legend>Contáctanos</legend>
                    <div class="contenedor-campos">
                        <div class="campo">
                            <label>Nombre</label>
                            <input class="input-text" type="text" placeholder="Tu nombre">
                        </div>
                        
                        <div class="campo">
                            <label>Teléfono</label>
                            <input class="input-text" type="tel" placeholder="Tu número">
                        </div>
                        
                        <div class="campo">
                            <label>Correo Electrónico</label>
                            <input class="input-text" type="email" placeholder="Tu correo electrónico">
                        </div>
                        
                        <div class="campo">
                            <label>Mensaje</label>
                            <textarea class="input-text" placeholder="¿En qué te podemos ayudar?"></textarea>
                        </div>
                    </div>

                    <div style="text-align: center;">
                        <input class="boton" type="submit" value="Enviar">
                    </div>
                </fieldset>
            </form>
        </section>
    </main>

    <footer class="footer">
        <p>Todos los derechos reservados LuciMakeup Store</p>
    </footer>

    <script src="JS/productos.js"></script>
    <script src="JS/carrito.js"></script>
</body>
</html>