# Sistema de Gestión de Concesionario de Vehículos

## Descripción del Proyecto

Este exámen tiene como objetivo mejorar la gestión de información en un concesionario de vehículos, utilizando una base de datos diseñada en PostgreSQL y archivos SQL para consultas. Se busca crear una base de datos bien estructurada que incluya detalles sobre el inventario de vehículos, clientes y ventas, historial de servicios, proveedores de piezas, empleados y departamentos. Se prioriza la implementación de consultas específicas para mejorar la eficiencia en la gestión de ventas y servicios, así como para proporcionar análisis útiles para la toma de decisiones.

---


## Estructura de la Base de Datos (Requerimientos)

El esquema relacional contempla las siguientes áreas clave del concesionario:

- **Inventario de Vehículos:** registro detallado de unidades (marca, modelo, año, precio, estado nuevo/usado, disponibilidad).
- **Clientes y Ventas:** datos personales de compradores e historial de transacciones realizadas.
- **Historial de Servicios:** registro de mantenimientos y reparaciones, indicando vehículo, empleado a cargo y fecha.
- **Proveedores de Piezas:** directorio de suministradores de componentes utilizados en el taller.
- **Empleados y Departamentos:**
  - *Ventas:* rendimiento comercial, comisiones generadas y transacciones asociadas.
  - *Servicio:* personal técnico, servicios asignados y horarios de trabajo.
- **Clientes Potenciales (Leads):** seguimiento de prospectos interesados en vehículos específicos, como insumo para estrategias de marketing.


---

## Consultas Implementadas

1. **Inventario Activo** — Listado de vehículos disponibles para la venta (marca, modelo, precio).
2. **Actividad Reciente de Clientes** — Clientes con compras recientes junto al vehículo adquirido.
3. **Trazabilidad de Servicios** — Historial completo de mantenimiento por vehículo (técnicos y fechas incluidos).
4. **Cadena de Suministro** — Proveedores de las piezas utilizadas en cada mantenimiento.
5. **Rendimiento Comercial** — Comisiones generadas por cada asesor de ventas en un período específico.
6. **Productividad Técnica** — Servicios de mantenimiento realizados, filtrados por empleado.
7. **Estrategia de Marketing (Leads)** — Clientes potenciales cruzados con sus vehículos de interés.
8. **Gestión de Turnos** — Plantilla del departamento de servicio con sus horarios de trabajo.
9. **Análisis de Precios** — Vehículos vendidos dentro de un rango de precio específico.
10. **Fidelización de Clientes** — Clientes con más de una compra registrada en el concesionario.

---

## Autores

- **Juan David Gamboa Orozco**
- **Luis Esteban Ramirez Campo**
