create schema if not exists concesionario;
set search_path to concesionario;


create table inventario_vehiculos(
	id_vehiculo serial primary key,
	marca varchar(50) not null,
	modelo varchar(50),
	anio smallint not null,
	precio decimal(10,2) not null,
	estado varchar CHECK (estado IN ('nuevo','usado')) NOT NULL DEFAULT 'nuevo',
	disponible boolean NOT NULL DEFAULT true
);

create table empleados(
	id_empleado serial primary key,
	nombre varchar(100) not null,
	cedula varchar(10) not null,
	rol varchar(50) not null,
	fecha_contratacion date not null
);

create table proveedores_piezas(
	id_proveedor serial primary key,
	nombre varchar(100) not null,
	cedula varchar(10) not null,
	telefono varchar(13)
);

create table clientes(
	id_cliente serial primary key,
	nombre varchar(100) not null,
	cedula varchar(10) not null,
	telefono varchar(10) not null
);

create table ventas(
	id_venta serial primary key,
	id_cliente_fk int NOT NULL,
	id_vehiculo_fk int NOT NULL,
	subtotal decimal(10,2) not null,
	fecha_compra date not null,
	FOREIGN KEY(id_cliente_fk) REFERENCES clientes(id_cliente),
	FOREIGN KEY(id_vehiculo_fk) REFERENCES inventario_vehiculos(id_vehiculo)
);

create table vehiculos_particulares(
	id_vehiculop serial primary key,
	id_clientep int,
	marca varchar(50),
	modelo varchar(50),
	FOREIGN KEY(id_clientep) REFERENCES clientes(id_cliente)
);

create table historial_servicios(
	id_historial serial primary key,
	id_vehiculop_fk int,
	id_proveedor_fk int,
	detallereparacion varchar(200),
	fecha_servicio date not null,
	FOREIGN KEY(id_vehiculop_fk) REFERENCES vehiculos_particulares(id_vehiculop),
	FOREIGN KEY(id_proveedor_fk) REFERENCES proveedores_piezas(id_proveedor)
);

create table departamento_ventas(
	id_vendedor serial primary key,
	id_empleado_fk int,
	id_venta_fk int,
	comisiones decimal(10,2),
	FOREIGN KEY(id_empleado_fk) REFERENCES empleados(id_empleado),
	FOREIGN KEY(id_venta_fk) REFERENCES ventas(id_venta)
);

create table departamento_servicio(
	id_mecanico serial primary key,
	id_empleado_fk int,
	id_historial_fk int,
	horario_trabajo varchar(200) not null,
	FOREIGN KEY(id_empleado_fk) REFERENCES empleados(id_empleado),
	FOREIGN KEY(id_historial_fk) REFERENCES historial_servicios(id_historial)
);

create table clientes_potenciales(
	id_potencial serial primary key,
	id_cliente_fk int,
	id_vehiculo_fk int,
	interesado boolean NOT NULL DEFAULT true,
	FOREIGN KEY(id_cliente_fk) REFERENCES clientes(id_cliente),
	FOREIGN KEY(id_vehiculo_fk) REFERENCES inventario_vehiculos(id_vehiculo)
);