# Lucimakeup Store

Sitio de tienda en línea con Node.js, Express y MySQL. Sirve el frontend estático de `public/` y la API en `/api/*`.

Este documento describe cómo se desplegó en una instancia de AWS Lightsail, con el dominio `luciamakeup.shop` y HTTPS.

## Arquitectura

```
Navegador --HTTPS--> Nginx (80/443) --> Node.js (127.0.0.1:3000, PM2) --> MySQL (localhost:3306)
```

- **Nginx:** recibe el tráfico público y lo reenvía a la app. Termina el HTTPS.
- **Node.js + PM2:** ejecuta `server.js` y lo mantiene activo.
- **MySQL:** solo acepta conexiones locales.
- **Certbot:** emite y renueva el certificado de Let's Encrypt.

## Variables de entorno

Se definen en un archivo `.env` (no se sube al repositorio). El ejemplo está en `.env.example`.

| Variable | Descripción |
| --- | --- |
| `PORT` | Puerto de la app (3000) |
| `DB_HOST` | Servidor MySQL (`localhost`) |
| `DB_USER` | Usuario de MySQL |
| `DB_PASSWORD` | Contraseña de MySQL |
| `DB_NAME` | Nombre de la base (`lucimakeup_db`) |
| `DB_PORT` | Puerto de MySQL (3306) |
| `DB_SSL` | `false` cuando la base está en el mismo servidor |
| `ADMIN_KEY` | Clave para las rutas `/api/admin` (cabecera `x-admin-key`) |

## Ejecución en local

```bash
npm install
cp .env.example .env   # y edita los valores
npm start
```

La app queda en `http://localhost:3000`.

## Despliegue en AWS Lightsail

### 1. Crear la instancia y abrir puertos

1. En Lightsail, crea una instancia Linux con el blueprint **OS only: Ubuntu** (22.04 o 24.04). El plan de 5 USD o el de 3,50 USD alcanza.
2. En la pestaña **Networking** de la instancia, en **IPv4 Firewall**, deja estas reglas:
   - SSH, TCP, puerto 22
   - HTTP, TCP, puerto 80
   - HTTPS, TCP, puerto 443
3. No abras el puerto 3306. MySQL solo se usa dentro del servidor.
4. En **Networking**, crea una **IP estática** y asóciala a la instancia. Así la dirección no cambia al reiniciar.

### 2. Instalar el software base

Conéctate por SSH (botón **Connect using SSH** en Lightsail, usuario `ubuntu`) y ejecuta:

```bash
sudo apt update && sudo apt upgrade -y
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs git nginx mysql-server
sudo npm install -g pm2
```

Verifica las versiones:

```bash
node -v && git --version && nginx -v && mysql --version && pm2 -v
```

### 3. Clonar el proyecto y crear la base de datos

```bash
cd ~
git clone https://github.com/AdrianaMora27/Lucimakup.git
```

Crea la base y un usuario propio. Usa una contraseña de **solo letras y números**. Los caracteres especiales, en particular `#`, pueden romper la lectura del `.env`.

```bash
sudo mysql
```

```sql
CREATE DATABASE lucimakeup_db CHARACTER SET utf8mb4;
CREATE USER 'lucimakeup'@'localhost' IDENTIFIED BY 'TU_CLAVE_SIMPLE';
GRANT ALL PRIVILEGES ON lucimakeup_db.* TO 'lucimakeup'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

El archivo `lucimakeup_db.sql/lucimakeup_db.sql` no crea ni selecciona la base, así que se indica al importar. Además, sus dos filas de ejemplo de `detallepedido` (líneas 88 a 90) apuntan a los productos 1 y 2, que no existen, y MySQL rechaza la llave foránea. Se genera una copia sin esas filas:

```bash
sed '88,90d' ~/Lucimakup/lucimakeup_db.sql/lucimakeup_db.sql > ~/lucimakeup_limpio.sql
grep -n "INSERT INTO \`detallepedido\`" ~/lucimakeup_limpio.sql   # no debe mostrar nada
sudo mysql lucimakeup_db < ~/lucimakeup_limpio.sql
```

Verifica la importación:

```bash
sudo mysql lucimakeup_db -e "SHOW TABLES; SELECT COUNT(*) FROM producto;"
```

### 4. Configurar y arrancar la app

```bash
cd ~/Lucimakup
npm install --omit=dev
cp .env.example .env
nano .env
```

Contenido del `.env`:

```
PORT=3000
DB_HOST=localhost
DB_USER=lucimakeup
DB_PASSWORD=TU_CLAVE_SIMPLE
DB_NAME=lucimakeup_db
DB_PORT=3306
DB_SSL=false
ADMIN_KEY=una-clave-larga-y-propia
```

Prueba que conecta a la base (detén con `Ctrl+C`). Debe mostrar `Conectado exitosamente a la base de datos`:

```bash
node server.js
```

Inicia la app con PM2 y haz que arranque con el servidor:

```bash
pm2 start server.js --name lucimakeup
pm2 save
pm2 startup
```

`pm2 startup` imprime una línea que empieza con `sudo env PATH=...`. Hay que ejecutarla. En esta instancia fue:

```bash
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u ubuntu --hp /home/ubuntu
pm2 save
```

Verifica:

```bash
pm2 status
systemctl is-enabled pm2-ubuntu            # debe responder: enabled
curl -s localhost:3000/api/productos | head -c 300
```

### 5. Configurar Nginx como proxy inverso

```bash
sudo nano /etc/nginx/sites-available/lucimakeup
```

Contenido:

```nginx
server {
    listen 80;
    listen [::]:80;
    server_name luciamakeup.shop www.luciamakeup.shop;

    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Activa el sitio, quita el de ejemplo, valida y recarga:

```bash
sudo ln -s /etc/nginx/sites-available/lucimakeup /etc/nginx/sites-enabled/lucimakeup
sudo rm /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl reload nginx
```

### 6. Configurar el DNS

En el proveedor del dominio, crea registros que apunten a la IP estática de la instancia:

| Tipo | Nombre | Valor |
| --- | --- | --- |
| `A` | `@` (luciamakeup.shop) | IP estática |
| `A` o `CNAME` | `www` | IP estática (o `luciamakeup.shop`) |

Verifica desde el servidor:

```bash
dig +short luciamakeup.shop
dig +short www.luciamakeup.shop
```

Ambos deben devolver la IP de la instancia. Prueba `http://luciamakeup.shop` en el navegador.

### 7. Activar HTTPS con Certbot

```bash
sudo apt install -y certbot python3-certbot-nginx
sudo certbot --nginx -d luciamakeup.shop -d www.luciamakeup.shop
```

Indica un correo, acepta los términos y elige la opción de **redirigir HTTP a HTTPS**. Comprueba la renovación automática:

```bash
sudo certbot renew --dry-run
```

El sitio queda en `https://luciamakeup.shop`.

## Comprobaciones finales

1. La IP del dominio es una IP estática asociada a la instancia.
2. Tras `sudo reboot`, el sitio vuelve solo (PM2, Nginx y MySQL arrancan con el servidor).
3. Funcionan el registro, el inicio de sesión, el carrito, el checkout y el panel de administración.

## Actualizar el sitio

```bash
cd ~/Lucimakup && git pull && npm install --omit=dev && pm2 restart lucimakeup
```

No vuelvas a importar el `.sql` al actualizar: borraría los clientes y pedidos nuevos.

## Comandos útiles

```bash
pm2 status                      # estado de la app
pm2 logs lucimakeup             # registros de la app
pm2 restart lucimakeup          # reiniciar la app
sudo systemctl status nginx     # estado de Nginx
sudo nginx -t                   # validar la configuración de Nginx
sudo systemctl status mysql     # estado de MySQL
```

## Notas de seguridad

- Las contraseñas de los clientes se guardan y comparan en texto plano en `/api/registro` y `/api/login`. Es aceptable para un proyecto de clase, pero no uses datos ni contraseñas reales.
- El archivo `.env` no debe subirse al repositorio.
- Mantén cerrado el puerto 3306 en el firewall de Lightsail.
