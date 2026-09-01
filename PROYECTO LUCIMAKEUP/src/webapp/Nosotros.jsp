<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FrontEnd Store Lucimakeup</title>
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
        max-width: 100%;

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
/**NOSOTROS**/
.nosotros{
display: grid; 
grid-template-rows: repeat(2, auto);
}
@media (min-width: 768px) {
    .nosotros{

grid-template-columns: repeat(2, 1fr);
column-gap: 2rem;
}
}

.nosotros__imagen{
    grid-row: 1 / 2;
    width: 100%;
}

@media (min-width: 768px) {
    .nosotros__imagen{ 
        grid-column: 2 / 3;
    }
}

.contenido__contenido { 
    text-align: center;
}

/**BLOQUES**/

.bloques { 
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 2rem;
}

@media (min-width: 768px) {
    .bloques { 
        grid-template-columns: repeat(4, 1fr);
    }
}
.bloque { 
    text-align: center;

}
.bloque__titulo { 
    margin: 0;
    
}

.bloque__imagen{ 
    width: 30%;
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
        <a class="navegacion__enlace navegacion__enlace--activo" href="categorias.html">categorias</a>
        <a class="navegacion__enlace navegacion__enlace--activo" href="Nosotros.html">Nosotros</a>
    </nav>

    <main class="contenedor">
        <h1>Comunidad</h1>

        <div class="nosotros">
            <div class="contenido__contenido">
               <p>Todo comenzó en el año 2020, en uno de los momentos más difíciles para muchas familias. 
                En medio de la incertidumbre de la pandemia, dos hermanas decidieron unir fuerzas y convertir un sueño en realidad: nació Lucimakeup23. 
                Sin saber exactamente qué tan lejos llegaría este proyecto, empezamos a construirlo con dedicación, ofreciendo productos de calidad y un trato cercano a cada persona que nos elegía.
                 Hoy seguimos aquí, gracias a la confianza de nuestras clientas y a las recomendaciones que nos han permitido seguir creciendo. 
                 Lucimakeup23 es la prueba de que, incluso en los momentos más inciertos, los sueños compartidos pueden florecer.
                </p> 
            </div>
            <img class="nosotros__imagen" src="img/Nosotros.jpeg" alt="imagen nosotros">

        </div>
    </main>

    <section class="contenedor comprar">
        <h2 class="comprar__titulo">¿Por qué comprar con nosotros</h2>

        <div class="bloques">
            <div class="bloque">
                <img class="bloque__imagen" src="img/icono_1.jpeg" alt="por que comprar">
                <h3 class="bloque__titulo">El mejor precio</h3>
                <p>En Lucimakeup23 trabajamos directamente con nuestros proveedores, lo que nos permite ofrecerte precios justos sin intermediarios que encarezcan el producto final.
                     Al ser un emprendimiento familiar, nuestros costos operativos son bajos, y esa diferencia la trasladamos directamente a ti.</p>

            </div> <!--.bloque-->

         <div class="bloque">
                <img class="bloque__imagen" src="img/icono_2.jpeg" alt="por que comprar">
                <h3 class="bloque__titulo">Atencion oportuna</h3>
                <p>Sabemos que esperar respuestas te genera ansiedad, por eso en Lucimakeup23 respondemos tus mensajes lo más rápido posible. 
                    Ya sea que tengas dudas sobre un producto, necesites ayuda 
                    con tu pedido o simplemente quieras conocer más sobre nosotras, 
                    siempre estaremos disponibles para atenderte con la rapidez y calidez que mereces.</p>
            </div> <!--.bloque-->

         <div class="bloque">
                <img class="bloque__imagen" src="img/icono_3.jpeg" alt="por que comprar">
                <h3 class="bloque__titulo">La mejor calidad</h3>
                <p>Cada producto que ofrecemos pasa por nuestra revisión personal antes de llegar a ti. 
                    No vendemos lo que no compraríamos nosotras mismas. Por eso puedes confiar en que cada artículo de Lucimakeup23
                     cumple con los estándares de calidad que esperas, sin sorpresas ni decepciones.</p>
            </div> <!--.bloque-->
        
             <div class="bloque">
                <img class="bloque__imagen" src="img/icono_4.jpeg" alt="por que comprar">
                <h3 class="bloque__titulo">Envio gratis</h3>
                <p>Queremos que disfrutes tu compra sin preocuparte por costos adicionales. 
                    Por eso, en Lucimakeup23 el envío es completamente gratis — sin letras pequeñas, 
                    sin condiciones complicadas.
                     Tu pedido llega directo a tu puerta, sin que tengas que pagar de más.</p>
            </div> <!--.bloque-->

        </div><!---.bloques-->
    </section>

    <footer class="footer">
        <p class="footer__texto">Frontend store Lucimakeup - Todos los derechos reservados 2026</p>
    </footer>
    
    <script src="JS/carrito.js"></script>
    
</body>
</html>