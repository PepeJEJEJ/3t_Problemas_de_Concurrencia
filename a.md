0. Resumen previo: Transacciones y bloqueos
Antes de comenzar la práctica, es necesario comprender los conceptos básicos que se van a utilizar.

Una transacción es un conjunto de operaciones que se ejecutan como una única unidad. Su objetivo es garantizar que los datos se mantengan consistentes.

Una transacción puede finalizar de dos formas:

COMMIT: confirma los cambios realizados de forma permanente.
ROLLBACK: deshace todos los cambios realizados en la transacción.
Además, se pueden utilizar:

SAVEPOINT: permite establecer un punto intermedio dentro de la transacción.
ROLLBACK TO SAVEPOINT: permite volver a un punto concreto sin deshacer toda la transacción.
Durante una transacción, los cambios realizados solo son visibles para la sesión que los ejecuta. El resto de sesiones no ven los cambios hasta que se ejecuta un COMMIT.

Bloqueos
Cuando varias sesiones trabajan sobre los mismos datos, la base de datos utiliza bloqueos para evitar conflictos.

Existen dos aspectos importantes:

Nivel del bloqueo

Bloqueo de fila: afecta únicamente a un registro.
Bloqueo de tabla: afecta a toda la tabla.
Tipo de bloqueo

Transacción normal:
Una lectura no bloquea los datos.
Otros usuarios pueden modificar los datos mientras tanto.
Bloqueo exclusivo (FOR UPDATE):
Se bloquea la fila para su modificación.
Otras transacciones no pueden modificarla y quedan en espera.
Bloqueo compartido (LOCK IN SHARE MODE):
Varias transacciones pueden leer el mismo dato.
No se permite modificarlo mientras el bloqueo esté activo.
Idea clave
El bloqueo no depende solo de iniciar una transacción, sino de las operaciones que se realizan dentro de ella.

SELECT normal no bloquea.
UPDATE bloquea la fila automáticamente.
FOR UPDATE bloquea antes de modificar.
LOCK IN SHARE MODE permite leer pero impide modificar.
