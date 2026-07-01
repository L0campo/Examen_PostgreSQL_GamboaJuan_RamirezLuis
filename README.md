 Sistema de Gestión de Concesionario de Vehículos
Descripción del Proyecto
Este proyecto es una solución integral de bases de datos diseñada en PostgreSQL para optimizar la gestión de información de un concesionario de vehículos. Su objetivo principal es centralizar y estructurar los datos del inventario, ventas, clientes, servicios de taller y recursos humanos, permitiendo un análisis de datos eficiente para la toma de decisiones.

 Tecnologías Utilizadas
Base de Datos: PostgreSQL

Lenguaje de Consultas: SQL (DDL, DML, DQL)

Diseño: Modelo Entidad-Relación (MER)

 Estructura de la Base de Datos (Requerimientos)
El esquema relacional contempla las siguientes áreas clave del concesionario:

Inventario de Vehículos: Registro detallado de unidades (marca, modelo, año, precio, estado nuevo/usado).

Clientes y Ventas: Historial de transacciones y datos personales de compradores.

Historial de Servicios: Registro de mantenimientos y reparaciones (vehículo, empleado a cargo, fechas).

Proveedores de Piezas: Directorio de suministradores de componentes para el taller.

Empleados y Departamentos: * Ventas: Rendimiento, comisiones y transacciones.

Servicio: Personal técnico, servicios asignados y horarios.

Clientes Potenciales (Leads): Seguimiento de prospectos interesados en vehículos específicos.

 Estructura del Repositorio
Para desplegar este proyecto, los archivos están organizados de la siguiente manera:

docs/DER_Concesionario.png: Imagen de alta resolución con el Diagrama Entidad-Relación.

sql/01_schema.sql: Scripts de creación de tablas (DDL) y relaciones (Llaves primarias y foráneas).

sql/02_inserts.sql: Scripts de población de datos (DML) para pruebas.

sql/03_queries.sql: Solución a las consultas analíticas y operativas requeridas.

🔍 Consultas Implementadas
El archivo 03_queries.sql incluye las sentencias para resolver los siguientes requerimientos del negocio:

Inventario Activo: Listado de vehículos disponibles para la venta (marca, modelo, precio).

Actividad Reciente de Clientes: Clientes con compras recientes y detalles del vehículo adquirido.

Trazabilidad de Servicios: Historial completo de mantenimiento por vehículo (incluye técnicos y fechas).

Cadena de Suministro: Proveedores de las piezas utilizadas en los mantenimientos.

Rendimiento Comercial: Cálculo de comisiones generadas por los asesores de ventas en un periodo definido.

Productividad Técnica: Servicios de mantenimiento realizados filtrados por empleado específico.

Estrategia de Marketing (Leads): Cruce de clientes potenciales con sus vehículos de interés.

Gestión de Turnos: Plantilla del departamento de servicio con sus respectivos horarios.

Análisis de Precios: Vehículos vendidos dentro de un rango de precio específico.

Fidelización: Identificación de clientes con compras múltiples (lealtad).

 Instrucciones de Ejecución
Asegúrate de tener PostgreSQL instalado y ejecutándose en tu máquina.

Crea una base de datos vacía para el proyecto (ej. CREATE DATABASE concesionario_db;).

Ejecuta los scripts en el orden establecido en la estructura del repositorio:

Primero, ejecuta 01_schema.sql para construir la estructura.

Segundo, ejecuta 02_inserts.sql para cargar los datos de prueba.

Finalmente, utiliza 03_queries.sql para probar las consultas analíticas.
