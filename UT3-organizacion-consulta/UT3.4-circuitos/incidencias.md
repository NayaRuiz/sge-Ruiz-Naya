# UT3.4-circuitos
## Incidencias encontradas y soluciones aplicadas / comprobaciones pendientes

**1. Falta evidencia completa del pedido de venta con líneas y cantidades entregadas/facturadas**

La carpeta contiene una captura de confirmación del envío y del estado de la entrega, pero no se identifica una captura que muestre el pedido con las líneas y las columnas Entregado y Facturado que exige el enunciado.

**Solución / comprobación:** abrir el pedido confirmado de Clínica Dental Besaya S.L. y guardar una captura con sus líneas, la entrega vinculada y las cantidades entregadas y facturadas. Comprobar que contiene 1 SSD, 1 memoria RAM y 1 hora de mano de obra.

**2. Verificar el estado final de entrega, factura y pago**

El README describe la entrega como Hecho y la factura como publicada y pagada. Las capturas disponibles no permiten confirmar todos esos detalles de estado de forma inequívoca, y la factura PDF debe revisarse para verificar que corresponde a la operación documentada.

**Solución / comprobación:** comprobar la entrega vinculada al pedido, que esté en estado Hecho y que su documento de origen sea el pedido de venta. Abrir la factura, confirmar que está Publicada y Pagada y que su botón Pedidos de venta enlaza con el pedido correcto. Conservar la captura y el PDF de la factura.

**3. No está completa la evidencia del circuito de compra**

Hay captura de la solicitud de presupuesto generada y de inventario, pero no se identifica una captura específica de la recepción en estado Hecho ni de la factura de proveedor publicada con el pedido de compra enlazado y el importe pendiente de pago.

**Solución / comprobación:** abrir la solicitud de presupuesto de Componentes del Norte, confirmar el pedido, validar la recepción y generar/confirmar la factura de proveedor. Comprobar que la factura está Publicada, que el botón Compras lleva al pedido correspondiente y que no se ha registrado el pago. Añadir las capturas que falten.

**4. Completar referencias y estados en la tabla de documentos**

La tabla del README contiene referencias pendientes de consultar para la entrega, factura de cliente, solicitud/pedido de compra, recepción y factura de proveedor. No se deben dejar como “Consultar documento” en la entrega final ni inventar referencias.

**Solución / comprobación:** obtener las referencias de cada documento desde Odoo y completar la tabla con documento, referencia, estado final y documento de origen. Revisar que las referencias coincidan con los PDF y las capturas.

**5. Verificar la regla de reabastecimiento y sus evidencias antes de automatizar**

La regla está documentada con mínimo 5 y máximo 15 y el cálculo esperado de 12 unidades, pero debe conservarse evidencia de la pantalla Reposición antes de automatizarla. La captura de esa pantalla debe mostrar el pronóstico y la cantidad a pedir; una vez automatizada, la línea puede desaparecer.

**Solución / comprobación:** confirmar la regla, el proveedor, la ruta Comprar y los valores mínimo/máximo. Si no se dispone de la captura previa, consultar la regla y el pedido generado, documentando los valores comprobados sin afirmar que la captura se tomó antes si no fue así.

**6. Comprobar el historial de movimientos y el stock final**

El README recoge el historial esperado (entrada inicial de 4, salida de 1 y entrada de 12), pero debe comprobarse que el historial real coincide y que el stock final es 15.

**Solución / comprobación:** abrir Inventario → Informes → Historial de movimientos, filtrar por Disco SSD 500 GB y revisar los tres movimientos, sus cantidades, ubicaciones y documentos de origen. Verificar que el stock real final es 15.

**7. Ampliaciones pendientes**

No queda documentada la prueba del circuito de venta con Javier ni la ampliación con CRM en la base de datos `pruebas`.

**Solución / comprobación:** si se requieren para la entrega, realizar un presupuesto de prueba con Javier y explicar las acciones permitidas/bloqueadas por sus permisos. En la base `pruebas`, instalar CRM, crear una oportunidad, planificar una llamada, marcarla como Ganado y generar el presupuesto; explicar cómo CRM precede al presupuesto en el flujo comercial.
