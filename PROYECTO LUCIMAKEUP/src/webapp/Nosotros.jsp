<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nosotros - Lucimakeup</title>
    <link rel="stylesheet" href="css/normalize.css"> 
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
        max-width: 100%;
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
       SECCIÓN NOSOTROS (GRID RESPONSIVE)
       ========================================== */
    .nosotros {
        display: grid; 
        grid-template-rows: repeat(2, auto);
        background-color: var(--Blanco-crema);
        padding: 3rem;
        border-radius: 1rem;
        margin-top: 3rem;
        box-shadow: 0px 5px 15px rgba(0,0,0,0.1);
    }

    @media (min-width: 768px) {
        .nosotros {
            grid-template-columns: repeat(2, 1fr);
            column-gap: 4rem;
            align-items: center;
        }
    }

    .nosotros__imagen {
        grid-row: 1 / 2;
        width: 100%;
        border-radius: 1rem;
        object-fit: cover;
    }

    @media (min-width: 768px) {
        .nosotros__imagen { 
            grid-column: 2 / 3;
        }
    }

    .contenido__contenido { 
        text-align: left;
    }

    /* ==========================================
       BLOQUES DE CARACTERÍSTICAS (POR QUÉ COMPRAR)
       ========================================== */
    .comprar {
        margin-top: 4rem;
    }

    .comprar__titulo {
        color: var(--blanco);
        margin-bottom: 3rem;
    }

    .bloques { 
        display: grid;
        grid-template-columns: repeat(1, 1fr);
        gap: 2rem;
    }

    @media (min-width: 768px) {
        .bloques { 
            grid-template-columns: repeat(4, 1fr);
        }
    }

    .bloque { 
        background-color: var(--Blanco-crema);
        padding: 2rem;
        border-radius: 1rem;
        text-align: center;
        display: flex;
        flex-direction: column;
        align-items: center;
        box-shadow: 0px 5px 10px rgba(0,0,0,0.05);
    }

    .bloque__titulo { 
        margin: 1.5rem 0 1rem 0;
        color: var(--morado);
    }

    .bloque__imagen { 
        width: 25%;
        margin-top: 1rem;
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
        <a href="index.jsp">
            <img class="header__logo" src="img/logolucistore.png" alt="Logotipo Lucimakeup">
        </a>
    </header>

    <!-- NAVEGACIÓN DINÁMICA -->
    <nav class="navegacion">
        <a class="navegacion__enlace" href="index.jsp">Inicio</a>
        <a class="navegacion__enlace" href="CategoriasServlet">Categorías</a>
        <a class="navegacion__enlace" href="nosotros.jsp">Nosotros</a>
    </nav>

    <!-- CONTENIDO PRINCIPAL: HISTORIA Y COMUNIDAD -->
    <main class="contenedor">
        <h1>Comunidad y Origen</h1>

        <div class="nosotros">
            <div class="contenido__contenido">
               <p>Todo comenzó en el año 2020, en uno de los momentos más difíciles para muchas familias. 
                En medio de la incertidumbre de la pandemia, dos hermanas decidieron unir fuerzas y convertir un sueño en realidad: nació Lucimakeup23. 
                Sin saber exactamente qué tan lejos llegaría este proyecto, empezamos a construirlo con dedicación, ofreciendo productos de calidad y un trato cercano a cada persona que nos elegía.
                 Hoy seguimos aquí, gracias a la confianza de nuestras clientas y a las recomendaciones que nos han permitido seguir creciendo. 
                 Lucimakeup23 es la prueba de que, incluso en los momentos más inciertos, los sueños compartidos pueden florecer.
               </p> 
            </div>
            <img class="nosotros__imagen" src="img/Nosotros.jpeg" alt="Imagen de comunidad Lucimakeup">
        </div>
    </main>

    <!-- SECCIÓN DE VALORES Y BENEFICIOS -->
    <section class="contenedor comprar">
        <h2 class="comprar__titulo">¿Por qué comprar con nosotros?</h2>

        <div class="bloques">
            <!-- Bloque 1 -->
            <div class="bloque">
                <img class="bloque__imagen" src="img/icono_1.jpeg" alt="Icono mejor precio">
                <h3 class="bloque__titulo">El mejor precio</h3>
                <p>Trabajamos directamente con proveedores, ofreciendo precios justos sin intermediarios y con costos operativos optimizados como emprendimiento familiar.</p>
            </div>

            <!-- Bloque 2 -->
           <div class="bloque">
                <img class="bloque__imagen" src="img/icono_2.jpeg" alt="Icono atención oportuna">
                <h3 class="bloque__titulo">Atención oportuna</h3>
                <p>Respondemos tus mensajes de forma rápida y ágil para resolver cualquier duda sobre tus productos o pedidos con total calidez.</p>
            </div>

            <!-- Bloque 3 -->
           <div class="bloque">
                <img class="bloque__imagen" src="img/icono_3.jpeg" alt="Icono calidad garantizada">
                <h3 class="bloque__titulo">La mejor calidad</h3>
                <p>Cada artículo pasa por una revisión personal estricta para garantizar que cumple con los estándares que esperas recibir.</p>
            </div>
        
            <!-- Bloque 4 -->
           <div class="bloque">
                <img class="bloque__imagen" src="img/icono_4.jpeg" alt="Icono envío gratis">
                <h3 class="bloque__titulo">Envío gratis</h3>
                <p>Disfruta tu compra sin costos adicionales ni letras pequeñas; tu pedido llega directo a la puerta de tu hogar.</p>
            </div>
        </div>
    </section>

    <!-- PIE DE PÁGINA -->
    <footer class="footer">
        <p class="footer__texto">Tienda Virtual Lucimakeup - Todos los derechos reservados &copy; 2026</p>
    </footer>
    
    <!-- SCRIPT JS PARA EL CARRITO -->
    <script src="JS/carrito.js"></script>
</body>
</html>