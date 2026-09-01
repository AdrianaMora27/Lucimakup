<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirmación de Pedido - Lucimakeup Store</title>
    <link rel="stylesheet" href="css/normalize.css">
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
        --verde-exito: #2e7d32;
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
        max-width: 80rem;
        margin: 0 auto;
        padding: 0 2rem;
    }

    /* HEADER */
    .header {
        display: flex;
        justify-content: center;
    }

    .header__logo { 
        margin: 3rem 0;
        max-width: 25rem;
    }

    /* TARJETA DE CONFIRMACIÓN */
    .tarjeta-confirmacion {
        background-color: var(--Blanco-crema);
        border-radius: 1rem;
        padding: 3rem;
        margin-top: 2rem;
        box-shadow: 0px 5px 10px rgba(0,0,0,0.1);
        text-align: center;
    }

    .tarjeta-confirmacion__icono {
        font-size: 5rem;
        color: var(--verde-exito);
        margin-bottom: 1rem;
    }

    .tarjeta-confirmacion__titulo {
        font-family: var(--fuentePrincipal);
        font-size: 3.8rem;
        color: var(--morado-oscuro);
        margin: 0;
    }

    .tarjeta-confirmacion__subtitulo {
        font-size: 1.8rem;
        color: var(--oscuro);
        margin-top: 0.5rem;
    }

    .numero-pedido {
        background-color: var(--rosa-claro);
        display: inline-block;
        padding: 0.8rem 1.5rem;
        border-radius: 0.5rem;
        font-weight: bold;
        color: var(--morado-oscuro);
        margin: 1.5rem 0;
    }

    /* DETALLES DE LA COMPRA */
    .detalles-compra {
        border-top: 2px solid var(--rosa-claro);
        margin-top: 2rem;
        padding-top: 2rem;
        text-align: left;
    }

    .detalles-compra__titulo {
        font-family: var(--fuentePrincipal);
        font-size: 2.2rem;
        color: var(--morado-oscuro);
        margin-bottom: 1rem;
    }

    .detalles-compra__item {
        display: flex;
        justify-content: space-between;
        margin-bottom: 1rem;
        font-size: 1.6rem;
    }

    .detalles-compra__total {
        display: flex;
        justify-content: space-between;
        font-size: 2rem;
        font-weight: bold;
        border-top: 1px solid var(--rosa-claro);
        padding-top: 1rem;
        margin-top: 1.5rem;
    }

    /* BOTÓN VOLVER */
    .boton-volver {
        display: inline-block;
        background-color: var(--primario);
        color: var(--negro);
        font-family: var(--fuentePrincipal);
        font-size: 2.2rem;
        padding: 1.2rem 3rem;
        border-radius: 0.5rem;
        text-decoration: none;
        margin-top: 2.5rem;
        transition: background-color 0.3s ease;
    }

    .boton-volver:hover {
        background-color: var(--morado);
        color: var(--blanco);
    }

    /* FOOTER */
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
        <a href="index.html">
            <img class="header__logo" src="img/logolucistore.png" alt="Logotipo Lucimakeup">
        </a>
    </header>

    <main class="contenedor">
        <div class="tarjeta-confirmacion">
            <div class="tarjeta-confirmacion__icono">✔</div>
            <h1 class="tarjeta-confirmacion__titulo">¡Gracias por tu compra!</h1>
            <p class="tarjeta-confirmacion__subtitulo">Tu pedido ha sido recibido exitosamente y se encuentra en proceso de despacho.</p>
            
            <div class="numero-pedido">
                Número de Pedido: #LUC-1024
            </div>

            <div class="detalles-compra">
                <h2 class="detalles-compra__titulo">Resumen del Pedido</h2>
                
                <div class="detalles-compra__item">
                    <span>Brillo Gloss (x1)</span>
                    <span>$12.000 COP</span>
                </div>

                 <div class="detalles-compra__item">
                    <span>Block 100 hojas (x1)</span>
                    <span>$8.000 COP</span>
                </div>
                
                 <div class="detalles-compra__item">
                    <span>Vela con aroma (x1)</span>
                    <span>$10.000 COP</span>
                </div>
                


                <div class="detalles-compra__item">
                    <span>Envío</span>
                    <span>$8.000 COP</span>
                </div>

                <div class="detalles-compra__total">
                    <span>Total Cancelado:</span>
                    <span>$30.000 COP</span>
                </div>
            </div>

            <a href="categorias.html" class="boton-volver">Seguir Comprando</a>
        </div>
    </main>

    <footer class="footer">
        <p class="footer__texto">Frontend store Lucimakeup - Todos los derechos reservados</p>
    </footer>
    <script src="JS/carrito.js"></script>
</body>
</html>