create schema if not exists Consesionario;

create table inventario_vehiculos(
	id_vehiculo serial primary key not null,
	marca varchar(50) not null,
	modelo varchar(50),
	anio varchar(4) not null,
	precio decimal(10,2) not null,
	estado varchar CHECK (estado IN ( 'nuevo','usado' )) NOT NULL DEFAULT 'nuevo',
	disponible varchar CHECK (disponible IN ( 'T','F' )) NOT NULL DEFAULT 'T'
);

insert into inventario_vehiculos values (1,'Toyota','Primavera','2025',50000,'nuevo','T');
insert into inventario_vehiculos values (2,'Toyota','Verano','2024',35000,'usado','T');
insert into inventario_vehiculos values (3,'Kia','Picanto','2025',2500,'nuevo','T');
insert into inventario_vehiculos values (4,'BMW','NFW','2024',9000,'usado','F');
insert into inventario_vehiculos values (5,'Ferrari','Horse','2025',8500,'nuevo','T');


create table empleados(
	id_empleado serial primary key not null,
	nombre varchar(100) not null,
	cedula varchar(10) not null,
	rol varchar(50) not null,
	fecha_contratacion date not null
);

insert into empleados values(1,'Carlos','111','Ventas','2026-06-25');
insert into empleados values(2,'Juan','222','Ventas','2026-06-12');
insert into empleados values(3,'Pipe','333','Mecanico','2025-08-25');
insert into empleados values(4,'Maria','444','Mecanico','2024-03-12');

create table proveedores_piezas(
	id_proveedor serial primary key not null,
	nombre varchar(100) not null,
	cedula varchar(10) not null,
	telefono varchar(13)
);

insert into proveedores_piezas values(1,'Pedro','111','123456789');
insert into proveedores_piezas values(2,'Samuel','222','987654321');


create table clientes(
	id_cliente  serial primary key not null,
	nombre varchar(100) not null,
	cedula varchar(10) not null,
	telefono varchar(10) not null
);

insert into clientes values(1,'Luis','111','1345678578');
insert into clientes values(2,'Carlos','222','2857295381');
insert into clientes values(3,'Arturo','333','2849327181');
insert into clientes values(4,'Rubiela','444','491283911');

create table ventas(
	id_venta  serial primary key not null,
	id_cliente_fk int,
	id_vehiculo_fk int,
	subtotal decimal(10,2) not null,
	fecha_compra date not null,
	FOREIGN KEY(id_cliente_fk) REFERENCES clientes(id_cliente),
	FOREIGN KEY(id_vehiculo_fk) REFERENCES inventario_vehiculos(id_vehiculo)
);

insert into ventas values(1,1,1,50000,'2026-06-25');
insert into ventas values(2,2,2,35000,'2026-06-26');
insert into ventas values(3,3,3,2500,'2026-06-12');

create table vehiculosParticulares(
	id_vehiculoP serial primary key not null,
	id_clienteP int,
	marca varchar(50),
	modelo varchar(50),
	FOREIGN KEY(id_clienteP) REFERENCES clientes(id_cliente)
);

insert into vehiculosParticulares values(1,4,'Ford','Fiesta');
insert into vehiculosParticulares values(2,4,'Fiat','Sandero');

create table historial_servicios(
	id_historial  serial primary key not null,
	id_vehiculoP_fk int,
	id_proveedor_fk int,
	detalleReparacion varchar(200),
	fecha_servicio date not null,	
	FOREIGN KEY(id_vehiculoP_fk) REFERENCES vehiculosParticulares(id_vehiculoP),
	FOREIGN KEY(id_proveedor_fk) REFERENCES proveedores_piezas(id_proveedor)
);

insert into historial_servicios values(1,1,1,'Llanta Pinchada','2026-06-12');
insert into historial_servicios values(2,2,1,'Cambio de aceite','2025-12-02');

create table departamento_ventas(
	id_vendedor  serial primary key not null,
	id_empleado_fk int,
	id_venta_fk int,
	comisiones decimal(10,2),
	FOREIGN KEY(id_empleado_fk) REFERENCES empleados(id_empleado),
	FOREIGN KEY(id_venta_fk) REFERENCES ventas(id_venta)
);

insert into departamento_ventas values(1,1,1,200);
insert into departamento_ventas values(2,1,2,1000);
insert into departamento_ventas values(3,2,3,500);


create table departamento_servicio(
	id_mecanico  serial primary key not null,
	id_empleado_fk int,
	id_historial_fk int,
	horario_trabajo varchar(200) not null,
	FOREIGN KEY(id_empleado_fk) REFERENCES empleados(id_empleado),
	FOREIGN KEY(id_historial_fk) REFERENCES historial_servicios(id_historial)
);

insert into departamento_servicio values(1,4,1,'Fines de Semana');
insert into departamento_servicio values(2,3,2,'Lunes a Viernes');


create table clientes_potenciales(
	id_potencial  serial primary key not null,
	id_cliente_fk int,
	interesado varchar CHECK (interesado IN ( 'T','F' )) NOT NULL DEFAULT 'T',
	FOREIGN KEY(id_cliente_fk) REFERENCES clientes(id_cliente)
);

insert into clientes_potenciales values(1,4,'T');



Listar Vehículos Disponibles: Obtener una lista de todos los vehículos disponibles para la venta, incluyendo detalles como marca, modelo, y precio.

select iv.* 
from inventario_vehiculos iv 
where iv.disponible  = 'T';

Clientes con Compras Recientes: Mostrar los clientes que han realizado compras recientemente, junto con la información de los vehículos adquiridos.


Historial de Servicios por Vehículo: Obtener el historial completo de servicios realizados para un vehículo específico, incluyendo detalles sobre los empleados involucrados y las fechas de servicio.

select hs.id_historial, c.nombre as "Nombre Cliente", v.marca , pp.nombre as "Proveedor", hs.detallereparacion, hs.fecha_servicio  
from historial_servicios hs 
join vehiculosparticulares v on v.id_vehiculop = hs.id_vehiculop_fk 
join proveedores_piezas pp on pp.id_proveedor = hs.id_proveedor_fk
join clientes c on c.id_cliente = v.id_clientep 
where v.id_vehiculop = 1;

Proveedores de Piezas Utilizados: Listar los proveedores de piezas que han suministrado componentes utilizados en los servicios de mantenimiento.

select pp.nombre , count(hs.id_proveedor_fk) as  "Suministraciones" 
from proveedores_piezas pp 
join historial_servicios hs on hs.id_proveedor_fk = pp.id_proveedor
group by pp.id_proveedor; 

Rendimiento del Personal de Ventas: Calcular las comisiones generadas por cada empleado del departamento de ventas en un período específico.

select e.nombre, sum(dv.comisiones)  
from departamento_ventas dv 
join ventas v on v.id_venta = dv.id_venta_fk
join empleados e on e.id_empleado = dv.id_vendedor
where (v.fecha_compra between '2026-06-01' and '2026-07-01') and e.rol = 'Ventas'
group by e.nombre;


Servicios Realizados por un Empleado: Identificar todos los servicios de mantenimiento realizados por un empleado específico, incluyendo detalles sobre los vehículos atendidos.

select e.nombre, v.marca, v.modelo, hs.detallereparacion, hs.fecha_servicio  
from departamento_servicio ds 
join empleados e on e.id_empleado = ds.id_empleado_fk
join historial_servicios hs on hs.id_historial = ds.id_historial_fk 
join vehiculosparticulares v on v.id_vehiculop = hs.id_vehiculop_fk 
where e.nombre = 'Pipe';

Clientes Potenciales y Vehículos de Interés: Mostrar información sobre los clientes potenciales y los vehículos de su interés, proporcionando pistas valiosas para estrategias de marketing.

Empleados del Departamento de Servicio: Listar todos los empleados que pertenecen al departamento de servicio, junto con sus horarios de trabajo.
Vehículos Vendidos en un Rango de Precios: Encontrar los vehículos vendidos en un rango de precios específico, proporcionando datos útiles para análisis de ventas.
Clientes con Múltiples Compras: Identificar a aquellos clientes que han realizado más de una compra en el concesionario, destacando la lealtad del cliente.














