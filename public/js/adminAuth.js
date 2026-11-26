// Utilidades compartidas del panel de administración.
// Envía la petición con la clave de admin. Si el servidor responde 403, descarta la clave guardada y la pide de nuevo una vez.
async function fetchAdmin(url, opciones = {}) {
    for (let intento = 0; intento < 2; intento++) {
        const clave = sessionStorage.getItem("adminKey");
        const respuesta = await fetch(url, {
            ...opciones,
            headers: { ...(opciones.headers || {}), "x-admin-key": clave || "" }
        });
        if (respuesta.status !== 403) return respuesta;
        sessionStorage.removeItem("adminKey");
        const nueva = prompt("Clave de administrador incorrecta. Inténtalo de nuevo:");
        if (!nueva) return respuesta;
        sessionStorage.setItem("adminKey", nueva);
    }
    return fetch(url, opciones);
}

// Verifica el rol admin y pide la clave si aún no se ha guardado. Devuelve false si debe abandonar la página.
function protegerPaginaAdmin() {
    const usuario = JSON.parse(localStorage.getItem("lucimakeup_usuario") || localStorage.getItem("usuarioLogueado"));
    if (!usuario || usuario.rol !== "admin") {
        alert("❌ Acceso denegado. Esta sección es exclusiva para administradores.");
        window.location.href = "index.html";
        return false;
    }
    const clave = sessionStorage.getItem("adminKey") || prompt("Clave de administrador:");
    if (!clave) { window.location.href = "index.html"; return false; }
    sessionStorage.setItem("adminKey", clave);
    return true;
}
