<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>errores-Lucimakeup</title>
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
        }

        * { 
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: Verdana, Geneva, Tahoma, sans-serif;
        }

        body { 
        background-color: var(--rosa-fuerte);
        display: flex;
        justify-content: center; /*Alinea los elementos horizontalmente dentro del FLEX, center: alinea los elementos**/
        align-items: center; /*Alinea los elementos verticalmente dentro del FLEX, center: centra los elementos**/
        min-height: 100vh;
    }

    .contenedor-error { 
        width: 100%;
        display: flex;
        justify-content: center;
        align-items: center;

    }

    .caja-error { 
        background-color: var(--Blanco-crema);
        padding: 4rem;
        border-radius: 1rem;
        width: 45rem;
        text-align: center;
        border-top: 6px solid var(--rojo-oscuro);

    }

    .icono-error { 
        margin-bottom: 2rem;

    }

    h1 { 
        color: var(--rojo-oscuro);
        font-size: 2.5rem;
        margin-bottom: 2rem;

    }

    .mensajes { 
        margin-bottom: 2rem;

    }

    .error-item { 
        color: var(--oscuro);
        font-size: 1rem;
        margin-bottom: 1rem;
        text-align: left;
    }

    .botones { 
        display: flex;
        gap: 2rem;
        justify-content: center;

    }

    .boton-volver { 
        background-color: var(--oscuro);
        color: var(--blanco);
        padding: 1rem 2rem;
        border-radius: 0.5rem;
        text-decoration: none;
        font-size: 1.4rem;
    }

    .boton-intentar { 
        background-color: var(--rojo-oscuro);
        color: var(--blanco);
        padding: 1rem 2rem;
        border-radius: 0.5rem;
        text-decoration: none;
        font-size: 1.4rem;

    }
    </style>
</head>
<body>
    <div class="contenedor-error">
        <div class="caja-error">
            <!--ICONO DE ADVERTENCIA-->
            <div class="icono-error">
                <p><!--
                        version: "2.3"
                        unicode: "f6f0"
                        -->
                        <svg
                        xmlns="http://www.w3.org/2000/svg"
                        width="92"
                        height="92"
                        viewBox="0 0 24 24"
                        fill="currentColor"
                        >
                        <path d="M12 1.67c.955 0 1.845 .467 2.39 1.247l.105 .16l8.114 13.548a2.914 2.914 0 0 1 -2.307 4.363l-.195 .008h-16.225a2.914 2.914 0 0 1 -2.582 -4.2l.099 -.185l8.11 -13.538a2.914 2.914 0 0 1 2.491 -1.403zm.01 13.33l-.127 .007a1 1 0 0 0 0 1.986l.117 .007l.127 -.007a1 1 0 0 0 0 -1.986l-.117 -.007zm-.01 -7a1 1 0 0 0 -.993 .883l-.007 .117v4l.007 .117a1 1 0 0 0 1.986 0l.007 -.117v-4l-.007 -.117a1 1 0 0 0 -.993 -.883z" />
                        </svg></p>
            </div>
            <h1>¡Ups! Algo salió mal</h1>
        <!--MENSAJE DE ERROR-->

            <div class="mensajes">
                <p class="error-item">Usuario o contraseña incorrectos</p>
                <p class="error-item">El campo nombre es obligatorio</p>
                <p class="error-item">La fecha de nacimiento no es válida</p>
                <p class="error-item">El correo eléctronico no es válido</p>
            
            </div>

        <!--BOTONES-->
            <div class="botones">
                <a href="login.html" class="boton-volver">Volver al Login</a>
                <a href="registro.html" class="boton-intentar">Intentar nuevamente</a>

            </div>
        </div>
    </div>
    <script src="JS/carrito.js"></script>
</body>
</html>
