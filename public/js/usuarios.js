document.addEventListener("DOMContentLoaded", () => {
    if (!protegerPaginaAdmin()) return;

    const form = document.getElementById("form-usuario");
    const tbody = document.getElementById("tabla-usuarios-body");
    const buscador = document.getElementById("buscador");
    const btnCancelar = document.getElementById("btn-cancelar");
    const campos = ["idCliente", "nombre", "apellido", "telefono", "email", "password"];
    const el = (id) => document.getElementById(id);
    let temporizador;

    function celda(texto) {
        const td = document.createElement("td");
        td.textContent = texto ?? "";   // textContent evita inyectar HTML desde datos de usuarios
        return td;
    }

    function boton(texto, clase, accion) {
        const b = document.createElement("button");
        b.type = "button";
        b.className = clase;
        b.textContent = texto;
        b.addEventListener("click", accion);
        return b;
    }

    async function cargarUsuarios() {
        const termino = buscador.value.trim();
        const url = "/api/admin/clientes" + (termino ? `?buscar=${encodeURIComponent(termino)}` : "");
        try {
            const respuesta = await fetchAdmin(url);
            const datos = await respuesta.json();
            if (!respuesta.ok) { alert("Error: " + (datos.mensaje || respuesta.status)); return; }
            tbody.replaceChildren();
            if (datos.length === 0) {
                const tr = document.createElement("tr");
                const td = celda("No hay usuarios para mostrar.");
                td.colSpan = 7;
                tr.appendChild(td);
                tbody.appendChild(tr);
                return;
            }
            datos.forEach((u) => {
                const tr = document.createElement("tr");
                tr.append(
                    celda(u.idCliente),
                    celda(`${u.Nombre} ${u.Apellido || ""}`.trim()),
                    celda(u.telefono),
                    celda(u.Email),
                    celda(u.fecha_registro ? new Date(u.fecha_registro).toLocaleDateString("es-CO") : ""),
                    celda(u.pedidos)
                );
                const acciones = document.createElement("td");
                const caja = document.createElement("div");
                caja.className = "acciones-btn";
                caja.append(
                    boton("Editar", "btn-editar", () => prepararEdicion(u)),
                    boton("Eliminar", "btn-eliminar", () => eliminarUsuario(u))
                );
                acciones.appendChild(caja);
                tr.appendChild(acciones);
                tbody.appendChild(tr);
            });
        } catch (error) {
            console.error("Error al cargar usuarios:", error);
            alert("No se pudo conectar con el servidor backend.");
        }
    }

    function prepararEdicion(u) {
        el("idCliente").value = u.idCliente;
        el("nombre").value = u.Nombre;
        el("apellido").value = u.Apellido || "";
        el("telefono").value = u.telefono || "";
        el("email").value = u.Email;
        el("password").value = "";
        el("password").required = false;
        el("ayuda-password").textContent = "Déjala vacía para conservar la contraseña actual.";
        el("titulo-form").textContent = `Editar Usuario #${u.idCliente}`;
        el("btn-submit-text").textContent = "Actualizar Usuario";
        btnCancelar.style.display = "block";
        window.scrollTo({ top: 0, behavior: "smooth" });
    }

    function reiniciarFormulario() {
        form.reset();
        campos.forEach((c) => (el(c).value = ""));
        el("password").required = true;
        el("ayuda-password").textContent = "Obligatoria (6 a 50 caracteres).";
        el("titulo-form").textContent = "Agregar Nuevo Usuario";
        el("btn-submit-text").textContent = "Guardar Usuario";
        btnCancelar.style.display = "none";
    }

    async function eliminarUsuario(u) {
        const aviso = u.pedidos > 0
            ? `\n\nAtención: este usuario tiene ${u.pedidos} pedido(s) que también se eliminarán.`
            : "";
        if (!confirm(`¿Eliminar al usuario ${u.Email}?${aviso}`)) return;
        try {
            const respuesta = await fetchAdmin(`/api/admin/clientes/${u.idCliente}`, { method: "DELETE" });
            const resultado = await respuesta.json();
            alert(resultado.mensaje);
            if (resultado.exito) cargarUsuarios();
        } catch (error) {
            console.error("Error de red al eliminar:", error);
            alert("No se pudo conectar con el servidor backend.");
        }
    }

    form.addEventListener("submit", async (e) => {
        e.preventDefault();
        const id = el("idCliente").value;
        const datos = {
            nombre: el("nombre").value,
            apellido: el("apellido").value,
            telefono: el("telefono").value,
            email: el("email").value,
            password: el("password").value
        };
        try {
            const respuesta = await fetchAdmin(id ? `/api/admin/clientes/${id}` : "/api/admin/clientes", {
                method: id ? "PUT" : "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(datos)
            });
            const resultado = await respuesta.json();
            alert(resultado.mensaje);
            if (resultado.exito) {
                reiniciarFormulario();
                cargarUsuarios();
            }
        } catch (error) {
            console.error("Error en la petición:", error);
            alert("No se pudo conectar con el servidor backend.");
        }
    });

    btnCancelar.addEventListener("click", reiniciarFormulario);
    buscador.addEventListener("input", () => {
        clearTimeout(temporizador);
        temporizador = setTimeout(cargarUsuarios, 300);
    });

    cargarUsuarios();
});
