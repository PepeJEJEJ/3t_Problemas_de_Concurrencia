# 📝 Resumen previo: Transacciones y Bloqueos en MySQL

## 🔹 1. Transacciones

Una **transacción** es un conjunto de operaciones que se ejecutan como una única unidad para mantener la consistencia de los datos.

### ✔ Finalización de una transacción
- **COMMIT** → confirma los cambios de forma permanente.  
- **ROLLBACK** → deshace todos los cambios realizados.

### ✔ Puntos intermedios
- **SAVEPOINT** → crea un punto dentro de la transacción.  
- **ROLLBACK TO SAVEPOINT** → vuelve a ese punto sin deshacer toda la transacción.

📌 *Los cambios dentro de una transacción solo son visibles para la sesión que los ejecuta hasta que se hace un COMMIT.*

---

## 🔹 2. Bloqueos en MySQL

Cuando varias sesiones acceden a los mismos datos, MySQL utiliza **bloqueos** para evitar conflictos.

### ✔ Niveles de bloqueo
- **Bloqueo de fila** → afecta solo a un registro.  
- **Bloqueo de tabla** → afecta a toda la tabla.

### ✔ Tipos de bloqueo

#### 🔸 Transacción normal
- Las lecturas **no bloquean**.
- Otros usuarios pueden modificar los datos mientras tanto.

#### 🔸 Bloqueo exclusivo (`FOR UPDATE`)
- Bloquea la fila para modificarla.
- Otras transacciones quedan en espera si intentan modificarla.

#### 🔸 Bloqueo compartido (`LOCK IN SHARE MODE`)
- Varias transacciones pueden leer el mismo dato.
- No se permite modificarlo mientras el bloqueo esté activo.

---

## 🔹 3. Idea clave

El bloqueo **no depende solo de iniciar una transacción**, sino de las operaciones realizadas dentro de ella:

- `SELECT` normal → **no bloquea**.  
- `UPDATE` → **bloquea automáticamente** la fila.  
- `FOR UPDATE` → bloquea antes de modificar.  
- `LOCK IN SHARE MODE` → permite leer, pero impide modificar.

---

