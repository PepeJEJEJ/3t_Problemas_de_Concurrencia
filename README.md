# 3t_Problemas_de_Concurrencia
---

# 📘 Tema 14 — Transacciones y Problemas de Concurrencia  
**Asignatura: Bases de Datos**  
**Resumen para GitHub (README.md)**  

---

## 📌 1. Introducción  
Las bases de datos multiusuario permiten que varias personas accedan y modifiquen la información al mismo tiempo.  
Para mantener la **integridad y consistencia**, se utilizan **transacciones**, **bloqueos** y **mecanismos de control de concurrencia**.

---

## 📌 2. Transacciones  
Una **transacción** es un conjunto de operaciones SQL que se ejecutan como una unidad indivisible.

### 🔹 Propiedades ACID  
- **Atomicidad**: Todo o nada.  
- **Consistencia**: La BD pasa de un estado válido a otro válido.  
- **Aislamiento**: Una transacción no ve cambios de otra hasta que finaliza.  
- **Durabilidad**: Los cambios confirmados son permanentes.

### 🔹 Estados de una transacción  
- *Start* → *Active* → *Committed*  
- Si falla: *Failed* → *Aborted*  
- En distribuidas: *Partially committed / Prepared*

### 🔹 Comandos principales  
- `START TRANSACTION` / `BEGIN`  
- `COMMIT`  
- `ROLLBACK`

---

## 📌 3. SAVEPOINT y control interno  
Permiten dividir una transacción en puntos intermedios:

- **SAVEPOINT nombre** → crea un punto de guardado  
- **ROLLBACK TO nombre** → vuelve al punto  
- **RELEASE SAVEPOINT nombre** → elimina el punto  

---

## 📌 4. Problemas de concurrencia  
Cuando dos transacciones se ejecutan a la vez, pueden aparecer inconsistencias:

### 🔴 Lectura sucia (Dirty Read)  
Una transacción lee datos **no confirmados** de otra.

### 🟠 Lectura no repetible (Non‑Repeatable Read)  
Un mismo dato se lee dos veces y **cambia entre lecturas**.

### 🟡 Lectura fantasma (Phantom Read)  
Una consulta repetida devuelve **nuevas filas** insertadas por otra transacción.

### 🔵 Modificación perdida (Lost Update)  
Dos transacciones actualizan el mismo dato y **una sobrescribe a la otra**.

---

## 📌 5. Control de concurrencia  
Existen dos enfoques:

### 🔹 Bloqueo pesimista  
Bloquea el recurso **antes** de modificarlo.  
Evita conflictos, pero reduce concurrencia.
AVISA EN MEDIO

### 🔹 Bloqueo optimista  
Solo bloquea al **confirmar**.  
Útil cuando los conflictos son poco probables.
AVISA AL FINAL

### 🔹 Reglas de bloqueo (Oracle)  
- Lecturas no bloquean escrituras  
- Escrituras no bloquean lecturas  
- Escrituras sí bloquean otras escrituras  
- Solo se bloquea durante la modificación real

---

## 📌 6. Transacciones distribuidas  
Afectan a varios nodos o bases de datos.

### 🔹 Componentes  
- **Agente raíz**: coordina la transacción  
- **LTM**: manejadores locales  
- **DTM**: manejador global

### 🔹 Commit en dos fases  
1. **Preparación**: todos los nodos confirman que pueden ejecutar  
2. **Commit global**: todos aplican o todos deshacen

---

## 📌 7. Políticas de bloqueo  
### 🔹 Niveles  
- **Tabla completa**  
- **Fila**  
- **Página**

### 🔹 Tipos  
- **Shared (S)**: lectura compartida  
- **Exclusive (X)**: escritura exclusiva  
- **Update (U)**: evita deadlocks en actualizaciones

---

## 📌 8. Procesamiento de consultas  
### 🔹 Procesadores locales  
Ejecutan consultas en un único nodo.

### 🔹 Procesadores distribuidos  
Dividen, optimizan y combinan consultas entre varios nodos.

---

## 📌 9. Casos prácticos  
### 🧪 Caso 1: Manejo de transacciones  
Uso de `COMMIT`, `SAVEPOINT` y `ROLLBACK`.  
Conclusión: **tras un COMMIT no se puede deshacer**.

### 🧪 Caso 2: Padres e hijos  
Para evitar borrar un padre mientras se inserta un hijo:  
```sql
SELECT * FROM padre WHERE nombre = 'X' FOR UPDATE;
```
Bloquea la fila del padre durante la operación.

---
# 📌 7.X Ejemplos prácticos de bloqueos

A continuación se muestran ejemplos reales de cómo funcionan los bloqueos en SQL, aplicados sobre la base de datos `tienda_bloqueo`.

---

## 🟥 Bloqueo de tabla (Nivel 1)

Bloquea **toda la tabla**, impidiendo que otras transacciones lean o modifiquen cualquier fila hasta que se libere.

### 🧪 Ejemplo (MySQL)

**Consola 1**
```sql
START TRANSACTION;
LOCK TABLES productos WRITE;   -- 🔒 Bloqueo total de la tabla
SELECT * FROM productos;
```

**Consola 2**
```sql
SELECT * FROM productos;                     -- ❌ Espera
UPDATE productos SET stock = stock - 1;      -- ❌ Espera
```

**Consola 1 libera**
```sql
UNLOCK TABLES;
COMMIT;
```

✔ La otra consola continúa.

---

## 🟧 Bloqueo de fila (Nivel 2)

Solo se bloquea **una fila concreta**, permitiendo trabajar con el resto de la tabla.

### 🧪 Ejemplo (MySQL / Oracle)

**Consola 1**
```sql
START TRANSACTION;
SELECT * FROM productos WHERE id = 1 FOR UPDATE;  -- 🔒 Bloqueo de fila
UPDATE productos SET stock = stock - 1 WHERE id = 1;
```

**Consola 2**
```sql
UPDATE productos SET stock = stock - 1 WHERE id = 1;   -- ❌ Bloqueado
UPDATE productos SET stock = stock - 1 WHERE id = 2;   -- ✔ Funciona
```

---

## 🟨 Bloqueo compartido (S) — *EL 3º QUE PEDISTE*

Permite leer, pero **no permite modificar** mientras dure el bloqueo.  
*(Disponible en MySQL; Oracle no lo soporta.)*

### 🧪 Ejemplo (MySQL)

```sql
START TRANSACTION;
SELECT * FROM productos 
WHERE id = 1 
LOCK IN SHARE MODE;   -- 🔒 Bloqueo S
```

**Consola 2**
```sql
UPDATE productos SET stock = stock - 1 WHERE id = 1;   -- ❌ Bloqueado
```

✔ La lectura está permitida, pero la escritura queda bloqueada.

---
