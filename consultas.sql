Listar Vehículos Disponibles: Obtener una lista de todos los vehículos disponibles para la venta, incluyendo detalles como marca, modelo, y precio.

select iv.* 
from inventario_vehiculos iv 
where iv.disponible = true;


Clientes con Compras Recientes: Mostrar los clientes que han realizado compras recientemente, junto con la información de los vehículos adquiridos.

select c.nombre as "Cliente", iv.marca, iv.modelo, v.fecha_compra, v.subtotal
from ventas v
join clientes c on c.id_cliente = v.id_cliente_fk
join inventario_vehiculos iv on iv.id_vehiculo = v.id_vehiculo_fk
where v.fecha_compra >= (current_date - interval '30 days')
order by v.fecha_compra desc;


Historial de Servicios por Vehículo: Obtener el historial completo de servicios realizados para un vehículo específico, incluyendo detalles sobre los empleados involucrados y las fechas de servicio.

select hs.id_historial, c.nombre as "Nombre Cliente", vp.marca, e.nombre as "Mecanico", pp.nombre as "Proveedor",hs.detallereparacion, hs.fecha_servicio
from historial_servicios hs
join vehiculos_particulares vp on vp.id_vehiculop = hs.id_vehiculop_fk
join proveedores_piezas pp on pp.id_proveedor = hs.id_proveedor_fk
join clientes c on c.id_cliente = vp.id_clientep
left join departamento_servicio ds on ds.id_historial_fk = hs.id_historial
left join empleados e on e.id_empleado = ds.id_empleado_fk 
where vp.id_vehiculop = 1;

Proveedores de Piezas Utilizados: Listar los proveedores de piezas que han suministrado componentes utilizados en los servicios de mantenimiento.

select pp.nombre, count(hs.id_proveedor_fk) as "Suministraciones"
from proveedores_piezas pp
join historial_servicios hs on hs.id_proveedor_fk = pp.id_proveedor
group by pp.id_proveedor
order by count(hs.id_proveedor_fk) desc;


Rendimiento del Personal de Ventas: Calcular las comisiones generadas por cada empleado del departamento de ventas en un período específico.

select e.nombre, sum(dv.comisiones) as total_comisiones
from departamento_ventas dv
join ventas v on v.id_venta = dv.id_venta_fk
join empleados e on e.id_empleado = dv.id_empleado_fk
where (v.fecha_compra between '2026-06-01' and '2026-07-01') and e.rol = 'Ventas'
group by e.nombre
order by sum(dv.comisiones) desc;


Servicios Realizados por un Empleado: Identificar todos los servicios de mantenimiento realizados por un empleado específico, incluyendo detalles sobre los vehículos atendidos.

select e.nombre, vp.marca, vp.modelo, hs.detallereparacion, hs.fecha_servicio
from departamento_servicio ds
join empleados e on e.id_empleado = ds.id_empleado_fk
join historial_servicios hs on hs.id_historial = ds.id_historial_fk
join vehiculos_particulares vp on vp.id_vehiculop = hs.id_vehiculop_fk
where e.nombre = 'Maria';

Clientes Potenciales y Vehículos de Interés: Mostrar información sobre los clientes potenciales y los vehículos de su interés, proporcionando pistas valiosas para estrategias de marketing.

select c.nombre as "Cliente Potencial", c.telefono, iv.marca, iv.modelo, iv.precio, cp.interesado
from clientes_potenciales cp
join clientes c on c.id_cliente = cp.id_cliente_fk
join inventario_vehiculos iv on iv.id_vehiculo = cp.id_vehiculo_fk
where cp.interesado = true;

Empleados del Departamento de Servicio: Listar todos los empleados que pertenecen al departamento de servicio, junto con sus horarios de trabajo.

select distinct e.nombre, e.rol, ds.horario_trabajo
from departamento_servicio ds
join empleados e on e.id_empleado = ds.id_empleado_fk;

Vehículos Vendidos en un Rango de Precios: Encontrar los vehículos vendidos en un rango de precios específico, proporcionando datos útiles para análisis de ventas.

select iv.marca, iv.modelo, iv.anio, v.subtotal, v.fecha_compra
from ventas v
join inventario_vehiculos iv on iv.id_vehiculo = v.id_vehiculo_fk
where v.subtotal between 16000 and 40000
order by v.subtotal;

Clientes con Múltiples Compras: Identificar a aquellos clientes que han realizado más de una compra en el concesionario, destacando la lealtad del cliente.

select c.nombre, count(v.id_venta) as total_compras
from ventas v
join clientes c on c.id_cliente = v.id_cliente_fk
group by c.nombre
having count(v.id_venta) > 1
order by total_compras desc;
