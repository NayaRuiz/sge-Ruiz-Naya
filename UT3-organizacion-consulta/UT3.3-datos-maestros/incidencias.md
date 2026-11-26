# UT3.3-datos-maestros
## Incidencias encontradas y soluciones aplicadas / comprobaciones pendientes

**1. No está incluido claramente el fichero de productos original y el fichero corregido exigido**

En la carpeta de recursos se encuentran las hojas de clientes y proveedores, pero no se identifica de forma inequívoca el Excel original `productos_infotaller.xlsx` ni un fichero separado con la corrección del error intencionado. La evidencia de la importación y de la comprobación posterior no sustituye a los ficheros que pide entregar el enunciado.

**Solución / comprobación:** recuperar el Excel original proporcionado por Teams, corregir únicamente el campo/valor que Odoo detectó en la prueba de importación y guardar una copia corregida con un nombre claro, por ejemplo `productos_infotaller_corregido.xlsx`. Conservar ambos ficheros si se solicita documentar la corrección.

**2. El error intencionado de la importación no está explicado con suficiente detalle verificable**

El README señala que el fichero contenía un error, pero no especifica de forma definitiva qué campo o valor era incorrecto, el mensaje exacto que mostró Odoo ni la modificación aplicada. La captura debe permitir identificar el error.

**Solución / comprobación:** revisar la captura de la prueba de importación y el fichero corregido. Escribir en la memoria el campo/valor erróneo, el mensaje que mostró Odoo y cómo se corrigió en la hoja. No resolverlo cambiando el desplegable de coincidencias ni creando valores nuevos.

**3. Comprobar idioma de los contactos importados**

Las capturas muestran las importaciones y las comprobaciones, pero no permiten asegurar que todos los contactos importados tienen Spanish / Español como idioma. El idioma se hereda del usuario que realiza la importación.

**Solución / comprobación:** trabajar como Marta y comprobar el idioma de Clínica Dental Besaya S.L. y de los contactos importados. Si no aparece Spanish / Español, corregir las preferencias de Marta y actualizar el idioma de los contactos que corresponda.

**4. Verificar las cantidades por categoría y el seguimiento de inventario**

La memoria indica las cantidades esperadas (7 Piezas, 3 Accesorios y 2 Servicios), pero hay que confirmar que la lista se ha comprobado sin el filtro Bienes y agrupada por categoría, y que los productos de tipo Bienes tienen activado el seguimiento de inventario.

**Solución / comprobación:** quitar el filtro Bienes, agrupar por Categoría de producto y verificar las cantidades. Revisar también el seguimiento de inventario en los productos de tipo Bienes. Añadir evidencia si falta.

**5. Comprobar la exportación compatible y la actualización del 5 % sin duplicados**

Se incluye una captura de exportación y otra de precios actualizados, pero falta el fichero exportado y modificado que pide la entrega, y no queda demostrado mediante el fichero que se conservó la columna `id` sin modificar.

**Solución / comprobación:** conservar el XLSX exportado en modo compatible con importación, modificar un 5 % el precio de venta solo de referencias `PZ-`, mantener intacta la columna `id` y guardar el fichero actualizado. Reimportarlo y comprobar los precios y que no se han creado duplicados.

**6. Ampliación de exportación CSV pendiente de documentar**

No se incluye la explicación del separador y la codificación del CSV de clientes ni del posible problema al abrirlo directamente con Excel.

**Solución / comprobación:** exportar clientes a CSV, abrirlo con un editor de texto y documentar el separador y la codificación que se observan realmente. Explicar el posible efecto de la interpretación del separador o de los caracteres acentuados al abrirlo en Excel.
