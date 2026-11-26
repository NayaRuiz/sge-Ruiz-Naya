# UT3.1-puesta-en-marcha
## Incidencias encontradas y soluciones aplicadas / comprobaciones pendientes

**1. No se puede verificar la creación de la base de datos con la evidencia disponible**

En el repositorio no hay una captura del gestor de bases de datos mostrando la creación de `infotaller_xyz`, el idioma Español, el país España y la opción de datos de demostración desactivada. El README describe estos ajustes, pero la evidencia visual no permite confirmarlos.

**Solución / comprobación:** volver al gestor o a la base de datos y verificar que se creó con el nombre e idioma solicitados, país España y sin datos de demostración. Si ya está correcto, añadir una captura de la configuración o de la base de datos creada. No recrearla ni borrar datos solo para obtener la captura.

**2. Falta evidencia de algunos ajustes de la compañía**

La captura `Paso3_InformacionEmpresa.png` documenta la información de la compañía, pero no se encuentra una evidencia específica del diseño de documentos (plantilla, colores y pie de página) ni del almacén renombrado a `InfoTaller` con abreviatura `WH`.

**Solución / comprobación:** revisar los ajustes de la compañía y del almacén. Si los valores están correctos, añadir capturas de la configuración del diseño de documentos y del almacén. Si aún aparece `My Company`, cambiar el nombre a `InfoTaller` y conservar la abreviatura `WH`.

**3. No queda completamente documentada la localización española y las dependencias instaladas**

Hay capturas de aplicaciones instaladas y de los datos técnicos de Reparaciones, pero no se ve una comprobación inequívoca de `l10n_es` ni una relación completa de los módulos instalados automáticamente por dependencias.

**Solución / comprobación:** en Aplicaciones, quitar el filtro de aplicaciones, filtrar por instalados y comprobar `l10n_es`. Consultar la pestaña Datos técnicos de Reparaciones y anotar qué dependencias se instalaron automáticamente. Añadir una captura si falta.

**4. Verificar el principio de mínimo privilegio y los permisos reales**

Las capturas de usuarios y sus aplicaciones están incluidas, pero debe comprobarse que la plantilla de permisos por defecto tiene desmarcada Creación de productos y que Marta no tiene Ajustes. La documentación también indica que los usuarios se crearon desde cero y no duplicando otros.

**Solución / comprobación:** revisar la plantilla y cada ficha de usuario. Si algún usuario tiene grupos innecesarios o permisos excesivos, retirarlos y volver a comprobar el acceso con una sesión de ese usuario. Mantener el usuario técnico con Administración: Ajustes para no perder la capacidad de administrar permisos.

**5. Comprobación de accesos no demostrada para todos los usuarios**

Las capturas de las aplicaciones visibles documentan las pantallas de inicio, pero no prueban por sí solas que cada usuario carezca de acciones no permitidas dentro de los módulos.

**Solución / comprobación:** iniciar sesión por separado con Marta, Javier, Lucía y Daniel y verificar los accesos y acciones indicados en el enunciado. Cerrar sesión entre pruebas y no usar una ventana privada compartida con otra sesión de usuario.
