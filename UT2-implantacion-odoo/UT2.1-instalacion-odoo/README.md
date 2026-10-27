# UT2-Instalación Odoo
## Índice

1. [Objetivo de la práctica](#1-objetivo-de-la-práctica)
2. [Datos de la instalación](#2-datos-de-la-instalación)
3. [Arquitectura y estructura de directorios](#3-arquitectura-y-estructura-de-directorios)
4. [Proceso de instalación](#4-proceso-de-instalación)
   - [4.1. Preparación de la máquina virtual](#41-preparación-de-la-máquina-virtual)
   - [4.2. Actualización e instalación de dependencias](#42-actualización-e-instalación-de-dependencias)
   - [4.3. Instalación de PostgreSQL](#43-instalación-de-postgresql)
   - [4.4. Usuario de sistema y directorios](#44-usuario-de-sistema-y-directorios)
   - [4.5. Descarga de Odoo y entorno virtual](#45-descarga-de-odoo-y-entorno-virtual)
   - [4.6. Instalación de wkhtmltopdf](#46-instalación-de-wkhtmltopdf)
   - [4.7. Primera ejecución de Odoo](#47-primera-ejecución-de-odoo)
   - [4.8. Configuración y servicio systemd](#48-configuración-y-servicio-systemd)
5. [Creación y configuración de la base de datos](#5-creación-y-configuración-de-la-base-de-datos)
6. [Verificación de la instalación](#6-verificación-de-la-instalación)
7. [Copia de seguridad y restauración](#7-copia-de-seguridad-y-restauración)
8. [Incidencias](#8-incidencias)
9. [Conclusiones](#9-conclusiones)
10. [Capturas](#10-capturas)

## 1. Objetivo de la práctica

El objetivo de esta práctica es instalar **Odoo 18 Community desde el código fuente** en una máquina virtual con Ubuntu Server 24.04 LTS. Después de instalarlo, se configura para que funcione como un servicio del sistema, se crea una base de datos, se comprueba que las aplicaciones funcionan y se realiza una copia de seguridad que posteriormente se restaura.

Odoo es un ERP (*Enterprise Resource Planning*), es decir, un sistema de planificación de recursos empresariales que permite gestionar distintas áreas de una empresa desde una misma aplicación. En esta práctica se utilizan PostgreSQL como gestor de bases de datos y un navegador web como cliente.

## 2. Datos de la instalación

Completar esta tabla con los valores reales de la máquina virtual. No se deben publicar contraseñas.

| Elemento | Valor |
|---|---|
| Sistema operativo | Ubuntu Server 24.04 LTS |
| Versión de Python | 3.12.x — comprobar en el servidor |
| Versión de PostgreSQL | 16.x — comprobar en el servidor |
| Versión de Odoo | 18.0 Community |
| Nombre de la máquina (hostname) | `odoo-<apellido>` — **completar** |
| Usuario de administración de Linux | `alumno` — sustituir si se utilizó otro |
| Usuario de sistema de Odoo | `odoo18` |
| Rol de PostgreSQL | `odoo18` |
| Dirección IP de la máquina virtual | `<IP_DEL_SERVIDOR>` |
| Carpeta de instalación | `/opt/odoo18` |
| Código fuente de Odoo | `/opt/odoo18/odoo` |
| Entorno virtual de Python | `/opt/odoo18/venv` |
| Carpeta de módulos adicionales | `/opt/odoo18/custom-addons` |
| Fichero de configuración | `/etc/odoo18.conf` |
| Fichero de servicio | `/etc/systemd/system/odoo18.service` |
| Fichero de log | `/var/log/odoo18/odoo18.log` |
| Puerto web | `8069` |
| Base de datos inicial | `pruebas` |

## 3. Arquitectura y estructura de directorios

La instalación sigue una arquitectura cliente-servidor. PostgreSQL y Odoo se ejecutan en la máquina virtual, mientras que el navegador se ejecuta en el ordenador anfitrión.

| Componente | Función |
|---|---|
| PostgreSQL | Guarda los datos de Odoo, como clientes, productos, facturas y usuarios. |
| Servidor Odoo | Ejecuta la lógica de la aplicación y sirve la interfaz web. |
| Navegador web | Permite acceder a Odoo desde el ordenador anfitrión mediante la IP del servidor y el puerto `8069`. |
| `wkhtmltopdf` | Permite generar documentos PDF, como facturas e informes. |

Las rutas principales utilizadas son:

| Ruta | Contenido |
|---|---|
| `/opt/odoo18/odoo` | Código de Odoo y módulos oficiales. |
| `/opt/odoo18/venv` | Entorno virtual y librerías de Python necesarias para ejecutar Odoo. |
| `/opt/odoo18/custom-addons` | Módulos adicionales o desarrollados fuera de los oficiales. |
| `/etc/odoo18.conf` | Parámetros de configuración del servidor. |
| `/etc/systemd/system/odoo18.service` | Configuración del servicio que inicia Odoo. |
| `/var/log/odoo18/odoo18.log` | Registro de actividad y errores. |
| `/var/lib/postgresql` | Datos gestionados por PostgreSQL. |
| `/opt/odoo18/.local/share/Odoo/filestore` | Archivos adjuntos, imágenes y documentos asociados a las bases de datos. |

Es importante distinguir el código de Odoo, las librerías de Python y los datos. No se guardan todos en la misma ubicación. Para realizar una copia completa de una base de datos hay que conservar tanto los datos de PostgreSQL como el *filestore* correspondiente.

## 4. Proceso de instalación

### 4.1. Preparación de la máquina virtual

Se creó una máquina virtual en VMware Workstation con Ubuntu Server 24.04 LTS. La configuración indicada en la práctica es:

- Memoria RAM: 4096 MB.
- Procesadores: 2.
- Disco virtual: 25 GB.
- Adaptador de red: NAT.
- Instalación de OpenSSH Server para poder conectarse por terminal desde el ordenador anfitrión.

Durante la instalación se configuró el nombre de la máquina y un usuario normal de administración. El usuario `odoo18` se reserva para ejecutar el servicio y se crea más adelante.

Una vez iniciado Ubuntu, se consultó la dirección IP con:

```bash
ip a
```

La conexión SSH desde el ordenador anfitrión se realiza con este formato, sustituyendo los valores por los reales:

```bash
ssh alumno@<IP_DEL_SERVIDOR>
```

**Captura:** añadir una imagen de la salida de `ip a` donde se vea la IP de la máquina virtual.

### 4.2. Actualización e instalación de dependencias

Primero se actualizaron los paquetes del sistema y se configuró la zona horaria:

```bash
sudo apt update
sudo apt upgrade -y
sudo timedatectl set-timezone Europe/Madrid
sudo reboot
```

Después del reinicio, se instalaron las herramientas y librerías necesarias para descargar Odoo y compilar sus dependencias de Python:

```bash
sudo apt install -y git wget build-essential \
  python3-dev python3-venv python3-pip \
  libpq-dev libldap2-dev libsasl2-dev \
  libxml2-dev libxslt1-dev zlib1g-dev libjpeg-dev \
  libffi-dev libssl-dev
```

Estas dependencias son necesarias, entre otras cosas, para conectar Python con PostgreSQL, procesar XML e imágenes y compilar determinadas librerías.

Se puede comprobar la versión de Python y Git con:

```bash
python3 --version
git --version
```

### 4.3. Instalación de PostgreSQL

Se instaló PostgreSQL y se creó un rol específico para Odoo:

```bash
sudo apt install -y postgresql
sudo systemctl status postgresql
sudo -u postgres createuser --createdb --no-createrole --no-superuser odoo18
```

El rol `odoo18` tiene permiso para crear bases de datos, pero no es superusuario. De esta forma se aplica el principio de mínimo privilegio. Al coincidir el nombre del rol de PostgreSQL con el usuario Linux que ejecuta Odoo, la conexión local puede utilizar autenticación *peer*.

Comprobaciones:

```bash
psql --version
sudo -u postgres psql -c "\du"
```

En la salida de `\du` debe aparecer el rol `odoo18` con el atributo `Create DB`.

**Captura:** añadir la salida de `\du` donde aparezca el rol `odoo18`.

### 4.4. Usuario de sistema y directorios

Se creó el usuario de sistema que ejecutará Odoo y el directorio para los registros:

```bash
sudo useradd -m -d /opt/odoo18 -U -r -s /bin/bash odoo18
sudo mkdir -p /var/log/odoo18
sudo chown odoo18:odoo18 /var/log/odoo18
```

Odoo no debe ejecutarse como `root`. Utilizar un usuario específico limita los permisos del servicio y reduce el impacto que podría tener un problema de seguridad.

Comprobaciones:

```bash
id odoo18
ls -ld /opt/odoo18 /var/log/odoo18
```

### 4.5. Descarga de Odoo y entorno virtual

Se accedió al usuario `odoo18` para descargar el código fuente de la rama 18.0 y preparar el entorno de Python:

```bash
sudo -u odoo18 -i
git clone https://github.com/odoo/odoo.git --depth 1 --branch 18.0 --single-branch odoo
mkdir custom-addons
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip wheel setuptools
pip install -r odoo/requirements.txt
pip install phonenumbers
deactivate
exit
```

El entorno virtual (`venv`) separa las librerías que necesita Odoo de las del sistema operativo. Esto evita modificar las dependencias de Python que utiliza Ubuntu. La librería `phonenumbers` se instala adicionalmente porque puede ser necesaria para determinadas funciones de facturación electrónica.

Comprobaciones:

```bash
sudo -u odoo18 ls /opt/odoo18
sudo -u odoo18 /opt/odoo18/venv/bin/python -c "import psycopg2, lxml, PIL, ldap, phonenumbers; print('OK')"
```

La segunda orden debe mostrar `OK` si todas las librerías se importan correctamente.

### 4.6. Instalación de wkhtmltopdf

Se instaló `wkhtmltopdf`, una herramienta que Odoo utiliza para convertir informes HTML en documentos PDF:

```bash
cd /tmp
wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-3/wkhtmltox_0.12.6.1-3.jammy_amd64.deb
sudo apt install -y ./wkhtmltox_0.12.6.1-3.jammy_amd64.deb
rm wkhtmltox_0.12.6.1-3.jammy_amd64.deb
cd
```

Se comprobó la versión instalada con:

```bash
wkhtmltopdf --version
```

La salida esperada es la versión `0.12.6.1` e incluye el texto `with patched qt`, necesario para que los PDF generados tengan el formato esperado.

**Captura:** añadir la salida de `wkhtmltopdf --version`.

### 4.7. Primera ejecución de Odoo

Antes de configurarlo como servicio, se realizó una ejecución manual para comprobar que el servidor podía arrancar:

```bash
sudo -u odoo18 /opt/odoo18/venv/bin/python3 /opt/odoo18/odoo/odoo-bin \
  --addons-path=/opt/odoo18/odoo/addons,/opt/odoo18/custom-addons
```

Cuando el servidor indicó que el servicio HTTP estaba funcionando en el puerto `8069`, se abrió desde el navegador del ordenador anfitrión:

```text
http://<IP_DEL_SERVIDOR>:8069
```

En esta fase solo se comprobó que aparecía la pantalla inicial. Después se detuvo el proceso con `Ctrl + C`, ya que más adelante Odoo se ejecutaría mediante `systemd`.

### 4.8. Configuración y servicio systemd

#### Fichero de configuración

Se creó el fichero `/etc/odoo18.conf`:

```ini
[options]
admin_passwd = <CONTRASEÑA_MAESTRA>

db_host = False
db_port = False
db_user = odoo18
db_password = False

addons_path = /opt/odoo18/odoo/addons,/opt/odoo18/custom-addons
data_dir = /opt/odoo18/.local/share/Odoo

http_port = 8069
logfile = /var/log/odoo18/odoo18.log
log_level = info
```

La contraseña maestra debe sustituirse por una propia y **no debe subirse al repositorio**. Para guardar el fichero con permisos adecuados se utilizaron:

```bash
sudo chown odoo18:odoo18 /etc/odoo18.conf
sudo chmod 640 /etc/odoo18.conf
```

Función de los parámetros principales:

| Parámetro | Función |
|---|---|
| `admin_passwd` | Protege las operaciones de gestión de bases de datos desde la web. |
| `db_host` y `db_port` | Indican dónde está PostgreSQL. `False` utiliza la conexión local. |
| `db_user` y `db_password` | Definen las credenciales de conexión con PostgreSQL. |
| `addons_path` | Indica dónde se encuentran los módulos oficiales y los adicionales. |
| `data_dir` | Define dónde se guardan archivos asociados a Odoo, incluido el *filestore*. |
| `http_port` | Puerto por el que se accede a la aplicación web. |
| `logfile` | Ruta del fichero de registro. |
| `log_level` | Nivel de detalle de los registros. |

#### Servicio systemd

Se creó `/etc/systemd/system/odoo18.service` con este contenido:

```ini
[Unit]
Description=Odoo 18
Requires=postgresql.service
After=network.target postgresql.service

[Service]
Type=simple
User=odoo18
Group=odoo18
ExecStart=/opt/odoo18/venv/bin/python3 /opt/odoo18/odoo/odoo-bin -c /etc/odoo18.conf
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

Este servicio permite que Odoo se inicie automáticamente con el sistema. También configura el usuario con el que se ejecuta y permite reiniciarlo si se detiene por un fallo.

Para cargar la configuración y arrancar el servicio:

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now odoo18
sudo systemctl status odoo18
```

Comprobaciones adicionales:

```bash
sudo ss -tlnp | grep 8069
sudo tail -n 20 /var/log/odoo18/odoo18.log
systemctl is-enabled odoo18
```

El servicio debe aparecer como `active (running)`, el puerto `8069` debe estar escuchando y el servicio debe estar habilitado (`enabled`) para arrancar automáticamente.

**Captura:** añadir la salida de `systemctl status odoo18` y `ss -tlnp | grep 8069`.

## 5. Creación y configuración de la base de datos

Se accedió desde el navegador a `http://<IP_DEL_SERVIDOR>:8069` y se creó la base de datos inicial con estos valores:

| Campo | Valor o criterio |
|---|---|
| Contraseña maestra | La definida en `admin_passwd` |
| Nombre de la base de datos | `pruebas` |
| Correo del administrador | El indicado durante la instalación |
| Contraseña del administrador | Una contraseña propia |
| Idioma | Español |
| País | España |
| Datos de demostración | Activados para realizar pruebas |

La contraseña maestra sirve para gestionar bases de datos; no es la contraseña del usuario que inicia sesión en Odoo. La cuenta de administrador de Odoo pertenece a la base de datos creada.

Después de crear la base de datos, se activó la aplicación **Ventas**. La instalación puede incluir también Facturación y la localización española debido a las dependencias entre módulos. Se comprobó que aparecían los impuestos españoles, como el IVA del 21 %, 10 % y 4 %.

Comprobaciones desde el servidor:

```bash
sudo -u postgres psql -l
sudo ls /opt/odoo18/.local/share/Odoo/filestore/
```

Debe aparecer la base de datos `pruebas`, con el propietario `odoo18`, y su carpeta correspondiente en el *filestore*.

**Capturas que se deben añadir:**
- Formulario de creación de la base de datos, sin mostrar contraseñas.
- Aplicaciones instaladas en Odoo.
- Impuestos de la localización española.
- Salida de `sudo -u postgres psql -l`.

## 6. Verificación de la instalación

La instalación debe verificarse mediante pruebas concretas, no solo comprobando que se abre la página web. Completar la columna de resultado según lo que se haya comprobado realmente.

| Comprobación | Cómo se comprueba | Resultado |
|---|---|---|
| Servicio activo | `sudo systemctl status odoo18` | Pendiente de verificar |
| Arranque automático | Reiniciar la VM y ejecutar `systemctl is-enabled odoo18` | Pendiente de verificar |
| Puerto web | `sudo ss -tlnp \| grep 8069` | Pendiente de verificar |
| Registro de errores | `sudo grep -E "ERROR\|CRITICAL" /var/log/odoo18/odoo18.log` | Pendiente de verificar |
| Base de datos | `sudo -u postgres psql -l` | Pendiente de verificar |
| Acceso web | Abrir `http://<IP_DEL_SERVIDOR>:8069` | Pendiente de verificar |
| Localización española | Facturación → Configuración → Impuestos | Pendiente de verificar |
| Flujo de ventas | Crear un presupuesto, confirmarlo y generar una factura | Pendiente de verificar |
| Generación de PDF | Imprimir o descargar la factura | Pendiente de verificar |
| Filestore | `sudo ls /opt/odoo18/.local/share/Odoo/filestore/pruebas` | Pendiente de verificar |

Para completar la prueba funcional, se creó un presupuesto de prueba, se confirmó, se generó una factura y se comprobó que podía descargarse como PDF. Estas acciones deben marcarse como realizadas únicamente después de ejecutarlas y comprobar su resultado.

## 7. Copia de seguridad y restauración

La copia de seguridad se realizó desde el gestor de bases de datos de Odoo:

1. Se abrió `http://<IP_DEL_SERVIDOR>:8069/web/database/manager`.
2. En la base de datos `pruebas`, se seleccionó **Backup**.
3. Se introdujo la contraseña maestra y se eligió el formato ZIP, que incluye el *filestore*.
4. Se descargó y abrió el ZIP para comprobar que contenía `dump.sql`, la carpeta `filestore` y `manifest.json`.
5. Se seleccionó **Restore Database** y se restauró con el nombre `pruebas-restaurada`.
6. Se marcó **Neutralize** y se indicó que era una copia de la base de datos.
7. Se accedió a la base restaurada y se comprobó que estaban disponibles los datos de prueba y que el PDF podía descargarse.

La restauración permite comprobar que la copia es válida. Es necesario incluir tanto la base de datos como el *filestore*, porque PostgreSQL guarda los datos estructurados y el *filestore* contiene archivos adjuntos y documentos.

**Resultado de la restauración:** completar tras realizar la prueba.

**Capturas:** contenido del ZIP y base de datos restaurada con el presupuesto o la factura de prueba.

## 8. Incidencias

Las incidencias reales deben anotarse en el archivo [`incidencias.md`](incidencias.md), indicando el error, su causa y la solución aplicada. No se deben incluir errores que no hayan ocurrido.

| Nº | Fecha | Paso | Síntoma | Causa | Solución |
|---:|---|---|---|---|---|
| — | — | — | No se han documentado incidencias todavía. | — | — |

Si no se produjo ninguna incidencia, se puede dejar constancia de ello. Si ocurrió alguna, sustituir la fila anterior por los datos reales.

## 9. Conclusiones

Con esta práctica se trabaja la instalación de un ERP desde su código fuente y se comprende la relación entre Odoo, Python y PostgreSQL. También se aprende a separar el código de las dependencias, utilizar un usuario de sistema con permisos limitados y configurar un servicio mediante `systemd` para que se inicie automáticamente.

Otro aspecto importante es la copia de seguridad: no basta con guardar la base de datos, porque los archivos adjuntos y documentos se almacenan en el *filestore*. Por eso, restaurar la copia y comprobar que los datos y documentos siguen disponibles es una parte necesaria del proceso.

**Dificultades encontradas:** completar con las incidencias reales de la instalación.

**Qué mejoraría en una instalación para una empresa real:** antes de poner el sistema en producción, planificaría las copias de seguridad automáticas y sus pruebas de restauración, protegería las credenciales, limitaría el acceso de red, configuraría el acceso seguro mediante HTTPS y establecería una supervisión periódica de los registros y del estado del servicio.

## 10. Capturas

Guardar las capturas dentro de la carpeta `img/` y utilizar rutas relativas para que se vean en GitHub. Sustituir los nombres de ejemplo por los nombres de los archivos que se hayan guardado.

- **IP del servidor:** `img/01-ip-servidor.png`
- **Rol de PostgreSQL:** `img/02-rol-postgresql.png`
- **Versión de wkhtmltopdf:** `img/03-wkhtmltopdf.png`
- **Servicio y puerto:** `img/04-servicio-odoo.png`
- **Creación de la base de datos:** `img/05-creacion-bd.png`
- **Aplicaciones e impuestos:** `img/06-aplicaciones-impuestos.png`
- **Comprobación de PostgreSQL:** `img/07-listado-bd.png`
- **Copia y restauración:** `img/08-backup-restauracion.png`

Ejemplo para insertar una captura en este README:

```markdown
![Estado del servicio Odoo](img/04-servicio-odoo.png)
```

---

> **Antes de entregar:** sustituir todos los campos pendientes por los valores reales, insertar las capturas, completar la tabla de verificación y documentar las incidencias que hayan ocurrido. No incluir contraseñas reales ni el fichero de configuración con credenciales.
