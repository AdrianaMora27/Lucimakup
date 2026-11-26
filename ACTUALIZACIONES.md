# Flujo para actualizar el código y publicarlo

La rama `main` es la que corre en el servidor de Lightsail. Todo cambio sigue tres partes: se modifica el código en el computador, se sube a `main` en GitHub y se trae al servidor.

```
Computador (cambios) --push--> GitHub (main) --pull--> Servidor Lightsail (PM2)
```

## Flujo simple: trabajar directo en `main`

Es suficiente para un proyecto de clase, trabajando una sola persona.

### En el computador

1. Confirma que estás en `main` y actualizada:
   ```bash
   git checkout main
   git pull
   ```
2. Haz los cambios y pruébalos en local:
   ```bash
   npm start
   ```
3. Sube los cambios:
   ```bash
   git add archivo1 archivo2
   git commit -m "Describe el cambio"
   git push origin main
   ```

### En el servidor

4. Conéctate por SSH y aplica la actualización:
   ```bash
   cd ~/Lucimakup && git pull && npm install --omit=dev && pm2 restart lucimakeup
   ```
5. Verifica:
   ```bash
   pm2 status
   pm2 logs lucimakeup --lines 10 --nostream
   ```
   La app debe aparecer `online`. Prueba también `https://luciamakeup.shop`.

## Flujo con rama de trabajo

Úsalo si el cambio es grande o puede romper el sitio. Así no se toca `main` hasta que el cambio funcione.

1. Crea la rama desde `main`:
   ```bash
   git checkout main
   git pull
   git checkout -b mi-cambio
   ```
2. Haz commits en esa rama y súbela:
   ```bash
   git add archivo1 archivo2
   git commit -m "Describe el cambio"
   git push -u origin mi-cambio
   ```
3. Cuando el cambio funcione, tráelo a `main`:
   ```bash
   git checkout main
   git pull
   git merge mi-cambio
   git push origin main
   ```
4. Actualiza el servidor con el comando del paso 4 del flujo simple.

## Reglas importantes

- **No edites código en el servidor.** El servidor solo hace `git pull`. Los cambios locales allá bloquean el `pull`.
- **No subas `.env` ni `node_modules`.** Ya están en `.gitignore`. El `.env` del servidor se mantiene aparte y no cambia con el `pull`.
- **Cambios en la base de datos:** `git pull` no modifica las tablas ni las columnas. Aplica el cambio a mano en el servidor:
  ```bash
  sudo mysql lucimakeup_db
  ```
  No reimportes el `.sql` completo, porque borraría los clientes y pedidos que ya existen.
- **Cambios en `package.json`:** el `npm install --omit=dev` del comando de actualización instala las dependencias nuevas.
- **Variables de entorno nuevas:** si el código usa una variable nueva, agrégala al `.env` del servidor (`nano ~/Lucimakup/.env`) antes de reiniciar con `pm2 restart lucimakeup`.
- **Contraseñas en el `.env`:** usa solo letras y números. El carácter `#` se interpreta como comentario y corta el valor.

## Volver a una versión anterior

Si un cambio deja el sitio roto, vuelve temporalmente a un commit que funcionaba. En el servidor:

```bash
cd ~/Lucimakup
git log --oneline
git checkout <commit>
pm2 restart lucimakeup
```

Luego corrige el problema en el computador y sube la corrección a `main`. Para volver a seguir `main` en el servidor:

```bash
git checkout main
git pull
npm install --omit=dev
pm2 restart lucimakeup
```

## Comandos útiles

```bash
git status                  # ver cambios pendientes
git log --oneline -5        # últimos commits
git branch --show-current   # rama actual
pm2 status                  # estado de la app
pm2 logs lucimakeup         # registros de la app
```
