<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tienda Virtual LuciMakeup Store</title>
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
            --negro: #000;

            --fuentePrincipal: "Staatliches", sans-serif;
        }

        /* GLOBALES */
        html {
            font-size: 62.5%;
            box-sizing: border-box;
            scroll-behavior: smooth;
        }

        *, *:before, *:after {
            box-sizing: inherit;
        }

        body {
            font-size: 1.6rem;
            line-height: 1.5;
            font-family: Arial, Helvetica, sans-serif;
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
            font-family: var(--fuentePrincipal);
            text-decoration: none;
            text-transform: uppercase;
            border-radius: .5rem;
            display: inline-block;
            text-align: center;
            border: none;
            transition: background-color .3s ease, color .3s ease;
        }

        .boton:hover {
            cursor: pointer;
            background-color: var(--morado);
            color: var(--blanco);
        }

        .sombra {
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1);
            background-color: var(--Blanco-crema);
            padding: 3rem;
            border-radius: 2rem;
        }

        /* TIPOGRAFÍA Y TÍTULOS */
        h1, h2, h3 { 
            text-align: center;
            font-family: var(--fuentePrincipal);
            color: var(--oscuro);
            margin: 1rem 0;
        }

        h1 { font-size: 4rem; }
        h2 { font-size: 3.2rem; }
        h3 { font-size: 2.4rem; text-decoration: none; }

        .titulo-principal {
            text-align: center;
            font-size: 4.5rem;
            color: var(--oscuro);
            text-transform: uppercase;
            font-family: var(--fuentePrincipal);
            margin: 2rem 0;
        }

        .titulo-principal span {
            font-size: 2.5rem;
            color: var(--morado-oscuro);
        }

        /* NAVEGACIÓN Y MENÚ DESPLEGABLE */
        .nav-bg { 
            background-color: var(--rosa-fuerte);
            padding: 1rem 0;
            box-shadow: 0px 2px 5px rgba(0,0,0,0.05);
            position: relative;
            z-index: 100;
        }
            
        .navegacion-principal {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            align-items: center;
        }
        
        @media (min-width: 768px) {
            .navegacion-principal {
                flex-direction: row;
                justify-content: center;
                gap: 3rem;
            }
        }

        .navegacion-principal a, .dropdown-btn {
            display: block;
            text-align: center;
            padding: 1rem 1.5rem;
            color: var(--negro);
            text-decoration: none;
            font-family: var(--fuentePrincipal);
            font-size: 2.2rem;
            transition: color .3s ease;
            background: none;
            border: none;
            cursor: pointer;
        }

        .navegacion-principal a:hover,
        .navegacion-principal a.activo,
        .dropdown:hover .dropdown-btn {
            color: var(--morado);
        }

        /* Estilos específicos del Dropdown */
        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown-contenido {
            display: none;
            position: absolute;
            background-color: var(--Blanco-crema);
            min-width: 22rem;
            box-shadow: 0px 8px 16px rgba(0,0,0,0.15);
            border-radius: 0.8rem;
            overflow: hidden;
            top: 100%;
            left: 50%;
            transform: translateX(-50%);
            z-index: 200;
        }

        .dropdown-contenido a {
            color: var(--oscuro);
            padding: 1.2rem 1.6rem;
            text-decoration: none;
            display: block;
            font-size: 1.8rem;
            text-align: left;
            border-bottom: 1px solid var(--Gris-claro);
            transition: background-color .3s ease, color .3s ease;
        }

        .dropdown-contenido a:last-child {
            border-bottom: none;
        }

        .dropdown-contenido a:hover {
            background-color: var(--Rosa-sutil);
            color: var(--morado-oscuro);
        }

        /* Mostrar el menú desplegable en Hover */
        .dropdown:hover .dropdown-contenido {
            display: block;
        }

        /* HERO BANNER */
        .banner-hero { 
            background-image: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('img/Lucimakeup.jpg');
            background-repeat: no-repeat;
            background-size: cover;
            background-position: center center;
            height: 38rem;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 4rem;
        }

        .contenido-hero {
            text-align: center;
            color: var(--blanco);
            padding: 2rem;
        }

        .contenido-hero h2 {
            color: var(--blanco);
            font-size: 3.8rem;
            margin-bottom: 1rem;
        }

        .contenido-hero p {
            font-size: 2rem;
            margin-bottom: 2rem;
            color: var(--Blanco-crema);
        }

        /* CATEGORÍAS EN INICIO */
        .servicios-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 3rem;
        }

        @media (min-width: 768px) {
            .servicios-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        .tarjeta-categoria {
            background-color: var(--blanco);
            display: flex;
            flex-direction: column;
            align-items: center;
            text-decoration: none;
            padding: 3rem 2rem;
            border-radius: 1.5rem;
            transition: transform .3s ease, box-shadow .3s ease;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.05);
        }

        .tarjeta-categoria:hover {
            transform: translateY(-.5rem);
            box-shadow: 0px 8px 15px rgba(0,0,0,0.15);
        }

        .tarjeta-categoria h3 {
            color: var(--morado-oscuro);
            margin-top: 1.5rem;
        }

        .tarjeta-categoria p { 
            line-height: 1.6;
            text-align: center;
            font-size: 1.6rem;
            color: var(--oscuro);
            margin: 0;
        }

        .tarjeta-categoria .icono-contenedor {
            height: 12rem;
            width: 12rem;
            background-color: var(--Rosa-sutil);
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* CONTACTO */
        .contacto-seccion {
            margin-top: 5rem;
        }

        .formulario {
            background-color: var(--Rosa-sutil);
            width: min(65rem, 100%);
            margin: 3rem auto 0 auto;
            padding: 3rem;
            border-radius: 1.5rem;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.05);
        }

        .formulario fieldset { 
            border: none;
            padding: 0;
            margin: 0;
        }

        .formulario legend { 
            text-align: center;
            font-size: 2.4rem;
            font-family: var(--fuentePrincipal);
            text-transform: uppercase;
            margin-bottom: 2rem;
            color: var(--morado-oscuro);
        }

        .contenedor-campos { 
            display: grid;
            grid-template-columns: 1fr;
            gap: 1.5rem;
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

        .campo label { 
            color: var(--oscuro);
            font-weight: bold;
            margin-bottom: .5rem;
            display: block;
            font-size: 1.5rem;
        }

        .campo textarea {
            height: 12rem;
            resize: vertical;
        }

        .input-text { 
            width: 100%;
            border: 1px solid var(--gris);
            padding: 1.2rem;
            border-radius: .5rem;
            font-size: 1.5rem;
            font-family: Arial, Helvetica, sans-serif;
        }

        /* FOOTER */
        .footer {
            text-align: center;
            padding: 2rem 0;
            margin-top: 5rem;
            background-color: var(--Blanco-crema);
        }

        .footer p {
            font-family: var(--fuentePrincipal);
            font-size: 2.2rem;
            margin: 0;
            color: var(--oscuro);
        }
    </style>
</head>

<body>
    <header>
        <h1 class="titulo-principal">LuciMakeup <span>Store</span></h1>
    </header>

    <div class="nav-bg">
        <nav class="navegacion-principal contenedor">
            <a href="index.html" class="activo">Inicio</a>
            
            <!-- MENÚ DESPLEGABLE DE CATEGORÍAS -->
            <div class="dropdown">
                <button class="dropdown-btn">Categorías &#9662;</button>
                <div class="dropdown-contenido">
                    <a href="maquillaje.html">Maquillaje</a>
                    <a href="cuidadoPersonal.html">Cuidado Personal</a>
                    <a href="hogar.html">Estilo y Hogar</a>
                    <a href="papeleria.html">Papelería</a>
                </div>
            </div>

            <a href="Nosotros.html">Nosotros</a>
            <a href="login.html">Ingresar</a>
            <a href="#contacto">Contacto</a>
        </nav>
    </div>

    <section class="banner-hero">
        <div class="contenido-hero">
            <h2>Bienvenidos a LuciMakeup Store</h2>
            <p>Encuentra los mejores productos para tu estilo, belleza y cuidado personal</p>
            <a href="maquillaje.html" class="boton">Ver Catálogo</a>
        </div>
    </section>

    <main class="contenedor sombra">
        <h2>Nuestras Categorías Destacadas</h2>

        <div class="servicios-grid">
            <a href="cuidadoPersonal.html" class="tarjeta-categoria">
                <div class="icono-contenedor">
                    <svg xmlns="http://www.w3.org/2000/svg" width="60" height="60" viewBox="0 0 24 24" fill="none" stroke="#89119D" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M9 3m0 1a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v1a1 1 0 0 1 -1 1h-4a1 1 0 0 1 -1 -1z" />
                        <path d="M10 6v.98c0 .877 -.634 1.626 -1.5 1.77c-.866 .144 -1.5 .893 -1.5 1.77v8.48a2 2 0 0 0 2 2h6a2 2 0 0 0 2 -2v-8.48c0 -.877 -.634 -1.626 -1.5 -1.77a1.795 1.795 0 0 1 -1.5 -1.77v-.98" />
                        <path d="M7 12h10" />
                        <path d="M7 18h10" />
                        <path d="M11 15h2" />
                    </svg>
                </div>
                <h3>Cuidado Personal</h3>
                <p>Descubre mascarillas, kits de skincare y productos diseñados para consentir tu piel todos los días.</p>
            </a>

            <a href="hogar.html" class="tarjeta-categoria">
                <div class="icono-contenedor">
                    <svg xmlns="http://www.w3.org/2000/svg" width="60" height="60" viewBox="0 0 24 24" fill="#89119D">
                        <path d="M3.903 4.008l.183 -.008h10.828a2.08 2.08 0 0 1 2.086 2.077v.923h1.5c1.917 0 3.5 1.477 3.5 3.333v2.334c0 1.856 -1.583 3.333 -3.5 3.333h-1.663a5.33 5.33 0 0 1 -5.17 4h-4.334c-2.944 0 -5.333 -2.375 -5.333 -5.308v-8.618a2.08 2.08 0 0 1 1.903 -2.066m13.097 9.992h1.5c.843 0 1.5 -.613 1.5 -1.333v-2.334c0 -.72 -.657 -1.333 -1.5 -1.333h-1.5z" />
                    </svg>
                </div>
                <h3>Estilo y Hogar</h3>
                <p>Encuentra detalles únicos y accesorios para complementar tus espacios con un toque especial.</p>
            </a>

            <a href="papeleria.html" class="tarjeta-categoria">
                <div class="icono-contenedor">
                    <svg xmlns="http://www.w3.org/2000/svg" width="60" height="60" viewBox="0 0 24 24" fill="none" stroke="#89119D" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M17 3l4 4l-14 14l-4 -4z" />
                        <path d="M16 7l-1.5 -1.5" />
                        <path d="M13 10l-1.5 -1.5" />
                        <path d="M10 13l-1.5 -1.5" />
                        <path d="M7 16l-1.5 -1.5" />
                    </svg>
                </div>
                <h3>Papelería</h3>
                <p>Artículos creativos y funcionales diseñados para organizar tus proyectos e inspirar tu día.</p>
            </a>
        </div>

        <!-- SECCIÓN DE CONTACTO -->
        <section id="contacto" class="contacto-seccion">
            <h2>Escríbenos</h2>

            <form class="formulario">
                <fieldset>
                    <legend>Déjanos un mensaje</legend>
                    <div class="contenedor-campos">
                        <div class="campo">
                            <label for="nombre">Nombre Completo</label>
                            <input class="input-text" type="text" id="nombre" name="nombre" placeholder="Tu nombre" required>
                        </div>
                        
                        <div class="campo">
                            <label for="telefono">Teléfono / WhatsApp</label>
                            <input class="input-text" type="tel" id="telefono" name="telefono" placeholder="Tu número de contacto">
                        </div>
                        
                        <div class="campo">
                            <label for="correo">Correo Electrónico</label>
                            <input class="input-text" type="email" id="correo" name="correo" placeholder="Tu correo electrónico" required>
                        </div>
                        
                        <div class="campo">
                            <label for="mensaje">Mensaje</label>
                            <textarea class="input-text" id="mensaje" name="mensaje" placeholder="¿En qué podemos ayudarte?"></textarea>
                        </div>
                    </div>

                    <div style="text-align: center; margin-top: 2rem;">
                        <input class="boton" type="submit" value="Enviar Mensaje">
                    </div>
                </fieldset>
            </form>
        </section>
    </main>

    <footer class="footer">
    <p class="footer__texto">Frontend store Lucimakeup - Todos los derechos reservados</p>
    <p class="footer__info">
        📍 Girardot, Cundinamarca | 📱 @Lucimakeup23 | Email: tiendavirtual23@gmail.com
    </p>
</footer>
    <!-- Scripts de la tienda -->
    <script src="JS/productos.js"></script>
    <script src="JS/carrito.js"></script>
</body>
</html>