<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Errores - Lucimakeup</title>
    
    <!-- Archivo de Normalización CSS -->
    <link rel="stylesheet" href="<c:url value='/Normalize.css'/>"> 

    <style>
        :root {
            --blanco: #ffffff;
            --oscuro: #212121;
            --primario: #ffc107;
            --gris: #757575;
            --rosa-claro: #ffb6c1;
            --rosa-fuerte: #ff69b4;
            --rojo-oscuro: #880e2f;
            --Blanco-crema: #FFF8F5;
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
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .contenedor-error { 
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 2rem;
        }

        .caja-error { 
            background-color: var(--Blanco-crema);
            padding: 4rem;
            border-radius: 1rem;
            width: 45rem;
            text-align: center;
            border-top: 6px solid var(--rojo-oscuro);
            box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.15);
        }

        .icono-error { 
            margin-bottom: 2rem;
            color: var(--rojo-oscuro);
        }

        h1 { 
            color: var(--rojo-oscuro);
            font-size: 2.5rem;
            margin-bottom: 2rem;
            font-family: "Staatliches", sans-serif;
            letter-spacing: 0.1rem;
        }

        .mensajes { 
            margin-bottom: 2rem;
            text-align: left;
        }

        .error-item { 
            color: var(--oscuro);
            font-size: 1.4rem;
            margin-bottom: 1rem;
            padding: 0.8rem 1.2rem;
            background-color: rgba(136, 14, 47, 0.05);
            border-left: 4px solid var(--rojo-oscuro);
            border-radius: 0.4rem;
        }

        .botones { 
            display: flex;
            gap: 2rem;
            justify-content: center;
            flex-wrap: wrap;
        }

        .boton-volver { 
            background-color: var(--oscuro);
            color: var(--blanco);
            padding: 1rem 2rem;
            border-radius: 0.5rem;
            text-decoration: none;
            font-size: 1.4rem;
            transition: background-color 0.3s ease;
        }

        .boton-volver:hover {
            background-color: var(--gris);
        }

        .boton-intentar { 
            background-color: var(--rojo-oscuro);
            color: var(--blanco);
            padding: 1rem 2rem;
            border-radius: 0.5rem;
            text-decoration: none;
            font-size: 1.4rem;
            transition: background-color 0.3s ease;
        }

        .boton-intentar:hover {
            background-color: #600a1f;
        }
    </style>
</head>
<body>
    <div class="contenedor-error">
        <div class="caja-error">
            <!-- ICONO DE ADVERTENCIA -->
            <div class="icono-error">
                <svg xmlns="http://www.w3.org/2000/svg" width="72" height="72" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M12 1.67c.955 0 1.845 .467 2.39 1.247l.105 .16l8.114 13.548a2.914 2.914 0 0 1 -2.307 4.363l-.195 .008h-16.225a2.914 2.914 0 0 1 -2.582 -4.2l.099 -.185l8.11 -13.538a2.914 2.914 0 0 1 2.491 -1.403zm.01 13.33l-.127 .007a1 1 0 0 0 0 1.986l.117 .007l.127 -.007a1 1 0 0 0 0 -1.986l-.117 -.007zm-.01 -7a1 1 0 0 0 -.993 .883l-.007 .117v4l.007 .117a1 1 0 0 0 1.986 0l.007 -.117v-4l-.007 -.117a1 1 0 0 0 -.993 -.883z" />
                </svg>
            </div>
            
            <h1>¡Ups! Algo salió mal</h1>

            <!-- LISTA DINÁMICA DE ERRORES RECIBIDOS DEL SERVLET -->
            <div class="mensajes">
                <c:choose>
                    <c:when test="${not empty listaErrores}">
                        <c:forEach var="error" items="${listaErrores}">
                            <p class="error-item">${error}</p>
                        </c:forEach>
                    </c:when>
                    <c:when test="${not empty mensajeError}">
                        <p class="error-item">${mensajeError}</p>
                    </c:when>
                    <c:otherwise>
                        <p class="error-item">Se ha producido un error inesperado en el sistema. Por favor, intenta nuevamente.</p>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- BOTONES DE NAVEGACIÓN -->
            <div class="botones">
                <a href="<c:url value='/login.jsp'/>" class="boton-volver">Volver al Login</a>
                <a href="javascript:history.back()" class="boton-intentar">Intentar nuevamente</a>
            </div>
        </div>
    </div>
</body>
</html>