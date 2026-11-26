# UT3.2-grupo-menu
## Incidencias encontradas y soluciones aplicadas / comprobaciones pendientes

**1. Falta evidencia de los permisos originales del grupo Inventario / Usuario**

El enunciado pide mostrar la línea de permisos `product.template stock user` y explicar por qué Lucía no puede cambiar el precio. En las capturas disponibles no aparece claramente esa línea del grupo estándar; sí está la captura del intento de cambio de precio.

**Solución / comprobación:** abrir Ajustes → Usuarios y compañías → Grupos → Inventario / Usuario → Permisos de acceso, localizar el permiso del modelo `product.template` y capturarlo. Comprobar que el permiso de escritura no está concedido por ese grupo y documentar la explicación.

**2. No se encuentra la captura de visibilidad del menú Productos**

La evidencia del duplicado del menú no muestra de forma inequívoca la pestaña Visibilidad con el grupo `Jefe de taller` seleccionado. La captura existente `Paso3_CopiaProductos.png` no permite confirmar todos los campos exigidos por el enunciado.

**Solución / comprobación:** abrir el menú duplicado, comprobar que el nombre es Productos, que el menú padre está vacío y que Visibilidad está restringida únicamente al grupo Jefe de taller. Añadir una captura de esos campos.

**3. Comprobar que el grupo propio no concede creación ni eliminación**

La documentación describe permisos de lectura y escritura para `product.template` y `product.product`, sin crear ni eliminar. Debe comprobarse en la configuración real que las cuatro casillas están exactamente como se pide y que Lucía es la usuaria asignada al grupo.

**Solución / comprobación:** revisar las pestañas Heredado, Permisos de acceso y Usuarios del grupo Jefe de taller. Si algún permiso de Crear o Eliminar está marcado, desmarcarlo y guardar. Confirmar que el grupo hereda Inventario / Usuario.

**4. La prueba con Daniel y la prueba completa con Lucía necesitan evidencia suficiente**

Hay capturas del producto y de las pruebas de usuario, pero deben demostrar explícitamente los resultados finales: Lucía puede modificar el precio, no crear ni eliminar productos y ve el acceso directo; Daniel no ve el menú y no puede modificar precios.

**Solución / comprobación:** cerrar y volver a iniciar sesión después de modificar grupos o menús. Probar con ambos usuarios en sesiones separadas y guardar capturas donde se vean los resultados. Si Lucía conserva Creación de productos o grupos que Daniel no tiene y no corresponden, quitarlos y repetir la prueba.

**5. Ampliaciones del enunciado no documentadas**

No hay evidencia ni explicación de la consulta de la regla de registro de Ventas (dominio), de la prueba de quitar temporalmente Inventario / Usuario a Lucía, ni de la duplicación de la acción para cambiar su modo de vista a `list,form`.

**Solución / comprobación:** realizar estas ampliaciones si forman parte de la entrega evaluable, documentar el dominio y explicar la herencia. Restaurar después los permisos originales de Lucía y comprobar el menú y la acción duplicada.
