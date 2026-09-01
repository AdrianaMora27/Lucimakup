<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recuperar Contraseña - LuciMakeup Store</title>
    <link rel="stylesheet" href="css/normalize.css">
    <link href="https://fonts.googleapis.com/css2?family=Staatliches&display=swap" rel="stylesheet">
    <style>
        :root {
            --blanco: #ffffff;
            --oscuro: #212121;
            --morado: #9C27B0;
            --morado-oscuro: #89119D;
            --Rosa-sutil: #FCE4EC;
             --rosa-fuerte: #ff69b4;
            --Blanco-crema: #FFF8F5;
            --fuentePrincipal: "Staatliches", sans-serif;
        }
        body {
            font-family: Arial, sans-serif;
            background-color: var(--rosa-fuerte);
            margin: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .contenedor-recuperar {
            max-width: 45rem;
            margin: 5rem auto;
            background-color: var(--Blanco-crema);
            padding: 3rem;
            border-radius: 1.5rem;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.1);
            width: 90%;
        }
        h1 {
            font-family: var(--fuentePrincipal);
            color: var(--morado-oscuro);
            text-align: center;
            font-size: 3.5rem;
            margin-bottom: 1rem;
        }
        .instrucciones {
            text-align: center;
            color: var(--oscuro);
            font-size: 1.5rem;
            margin-bottom: 2rem;
            line-height: 1.4;
        }
        .campo {
            margin-bottom: 1.5rem;
        }
        .campo label {
            display: block;
            margin-bottom: .5rem;
            font-weight: bold;
            color: var(--oscuro);
        }
        .campo input {
            width: 100%;
            padding: 1.2rem;
            border: 1px solid #ccc;
            border-radius: 0.5rem;
            font-size: 1.5rem;
            box-sizing: border-box;
        }
        .boton {
            width: 100%;
            background-color: var(--morado);
            color: var(--blanco);
            border: none;
            padding: 1.2rem;
            font-family: var(--fuentePrincipal);
            font-size: 2rem;
            border-radius: 0.5rem;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .boton:hover {
            background-color: var(--morado-oscuro);
        }
        .enlaces-retorno {
            text-align: center;
            margin-top: 2rem;
            font-size: 1.5rem;
        }
        .enlaces-retorno a {
            color: var(--morado-oscuro);
            font-weight: bold;
            text-decoration: none;
            display: block;
            margin-top: 0.8rem;
        }
        .enlaces-retorno a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="contenedor-recuperar">
        <h1>Recuperar Contraseña</h1>
        <p class="instrucciones">Ingresa el correo electrónico asociado a tu cuenta y te enviaremos las instrucciones para restablecer tu contraseña.</p>
        
        <form action="login.html" method="GET">
            <div class="campo">
                <label for="correo">Correo Electrónico</label>
                <input type="email" id="correo" name="correo" placeholder="tu@correo.com" required>
            </div>
            <button type="submit" class="boton">Enviar Instrucciones</button>
        </form>

        <div class="enlaces-retorno">
            <a href="login.html">← Regresar a Iniciar Sesión</a>
            <a href="index.html">← Volver al Inicio</a>
        </div>
    </div>
</body>
</html>