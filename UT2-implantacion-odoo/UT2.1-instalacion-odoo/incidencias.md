# sge-Ruiz-Naya
## Incidencias encontradas y soluciones aplicadas

**1. Error al instalar las dependencias de Python (`psycopg2` y `python-ldap`)**

Durante la instalación de las dependencias de Odoo mediante `pip install -r requirements.txt`, se produjo un error al compilar los paquetes `psycopg2` y `python-ldap`. La instalación no pudo generar los paquetes necesarios.

**Solución:** Se instalaron las bibliotecas de desarrollo necesarias para la compilación, mediante el comando:

"sudo apt install -y libpq-dev libldap2-dev libsasl2-dev"

Después, se volvió a ejecutar la instalación de los requisitos de Odoo.

**2. Error de permisos al instalar paquetes en el entorno virtual**

Al instalar las dependencias, apareció un error `Permission denied` en la ruta `/opt/odoo18/venv/lib/python3.12/site-packages/xlwt`. Esto indicaba que el usuario que ejecutaba la instalación no tenía permisos suficientes para modificar los archivos del entorno virtual.

**Solución:** Se corrigió la propiedad de los archivos del entorno virtual para que pertenecieran al usuario y grupo `odoo18`:

"sudo chown -R odoo18:odoo18 /opt/odoo18/venv"

A continuación, se repitió la instalación utilizando el usuario `odoo18`.

**3. Error al comprobar las dependencias: módulo `phonenumbers` no encontrado**

Al ejecutar la comprobación de las bibliotecas de Python, apareció el error `ModuleNotFoundError: No module named 'phonenumbers'`. Esto se debía a que el paquete no estaba instalado en el entorno virtual de Odoo.

**Solución:** Se instaló el paquete utilizando el `pip` del entorno virtual:

"sudo -u odoo18 /opt/odoo18/venv/bin/pip install phonenumbers"

Finalmente, se repitió la comprobación de las dependencias para verificar que todos los módulos necesarios podían importarse correctamente.
