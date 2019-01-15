-- 3.3) Muestra las piezas de Madrid que son grises o rojas.

select * from pieza where ciudad='Madrid' and (color='Gris' or color='Rojo');

-- 3.4) Encontrar todos los suministros cuya cantidad está entre 200 y 300, ambos inclusive.

select * from ventas where 200<=cantidad and cantidad<=300;

-- 3.5) Mostrar todas las piezas que contengan la palabra tornillo, con la t en mayúscula o en minúscula.

select * from pieza where nompie like '%tornillo%' or nompie like '%Tornillo%';

-- 3.8) Encontrar los códigos de aquellos proyectos a los que sólo abastece 'S1'.

select codpj from ventas minus select codpj from ventas where codpro!='S1';

-- 3.9) Mostrar todas las ciudades de la base de datos. (Utilizar UNION).

select ciudad from proyecto union select ciudad from proveedor union select ciudad from pieza;

-- 3.10) Mostrar todas las ciudades de la base de datos. (Utilizar UNION ALL).

select ciudad from proyecto union all select ciudad from proveedor union all select ciudad from pieza;

-- 3.12) Mostrar las ternas que son de la misma ciudad pero que hayan realizado alguna venta.

select proveedor.codpro, proyecto.codpj, pieza.codpie, proveedor.ciudad
from proveedor, proyecto, pieza, ventas
where ventas.codpro=proveedor.codpro and ventas.codpj=proyecto.codpj
and pieza.codpie=ventas.codpie and proveedor.ciudad=proyecto.ciudad
and proveedor.ciudad=pieza.ciudad;

-- Más eficiente
select p.codpro, p.codpj, p.codpie, p.ciudad
from ventas,
(select codpro, codpie, codpj, pieza.ciudad
from proveedor, pieza, proyecto
where pieza.ciudad=proyecto.ciudad and pieza.ciudad=proveedor.ciudad) p
where ventas.codpj=p.codpj and ventas.codpie=p.codpie and ventas.codpro=p.codpro;

-- 3.13) Encontrar parejas de proveedores que no viven en la misma ciudad.

select p1.codpro, p1.ciudad, p2.codpro, p2.ciudad from proveedor p1, proveedor p2
where p1.ciudad!=p2.ciudad;

-- 3.14) Encuentra las piezas con máximo peso.

select * from pieza
minus
select p1.* from pieza p1, pieza p2 where p1.peso < p2.peso;

-- 3.15) Mostar las piezas vendidas por los proveedores de Madrid.

select distinct codpie from ventas, proveedor
where ventas.codpro=proveedor.codpro and proveedor.ciudad='Madrid';

-- 3.16) Encuentra la ciudad y los códigos de las piezas suministradas a cualquier proyecto por un proveedor que está en la misma ciudad donde está el proyecto.

select ciudad, codpie from
ventas,
(select codpj, codpro, proyecto.ciudad
from proveedor, proyecto
where proveedor.ciudad=proyecto.ciudad) p
where ventas.codpj=p.codpj and ventas.codpro=p.codpro;

-- 3.17) Listar las ventas ordenadas por cantidad, si algunas ventas coinciden en la cantidad se ordenan en función de la fecha de manera descendente.

select * from ventas
order by cantidad, fecha desc;

-- 3.19) Mostrar las piezas vendidas por los proveedores de Madrid. (Fragmentando la consulta con la ayuda del operador IN).

select distinct codpie from ventas
where codpro in
(select codpro from proveedor where proveedor.ciudad='Madrid');

-- 3.20) Encuentra los proyectos que están en una ciudad donde se fabrica alguna pieza.

select * from proyecto
where ciudad in (select ciudad from pieza);

-- 3.21) Encuentra los códigos de aquellos proyectos que no utilizan ninguna pieza roja que esté suministrada por un proveedor de Londres.

-- Considerando que se la suministre el proveedor de Londres:
select codpj from proyecto
where codpj not in (select codpj from ventas, proveedor, pieza
where ventas.codpro=proveedor.codpro and ventas.codpie=pieza.codpie
and proveedor.ciudad='Londres' and pieza.color='Rojo');

-- Considerando que se la suministre cualquier proveedor
select proyecto.codpj from proyecto
where proyecto.codpj not in (select v.codpj from ventas v
where v.codpie in (select ventas.codpie from ventas, proveedor, pieza
where ventas.codpro=proveedor.codpro and ventas.codpie=pieza.codpie
and proveedor.ciudad='Londres' and pieza.color='Rojo'));

-- 3.22) Muestra el código de las piezas cuyo peso es mayor que el peso de cualquier 'tornillo'.

select pieza.codpie from pieza
where pieza.peso > all (select peso from pieza
where nompie like 'Tornillo%');

-- 3.23) Encuentra las piezas con peso máximo. (Usando < | <= | > | >= ANY|ALL)

select * from pieza
where pieza.peso >= all (select peso from pieza);

-- 3.24) Encontrar los códigos de las piezas suministradas a todos los proyectos localizados en Londres.

select pieza.codpie from pieza
where not exists (select * from proyecto
where proyecto.ciudad='Londres'
and not exists (select * from ventas
where ventas.codpie=pieza.codpie and ventas.codpj=proyecto.codpj));

select pieza.codpie from pieza
where not exists
(select codpj from proyecto where proyecto.ciudad='Londres'
minus
select codpj from ventas where ventas.codpie=pieza.codpie); 

-- 3.25) Encontrar aquellos proveedores que envían piezas procedentes de todas las ciudades donde hay un proyecto.

select * from proveedor
where not exists
(select * from proyecto
where not exists
(select * from ventas, pieza
where ventas.codpie=pieza.codpie
and ventas.codpro=proveedor.codpro
and pieza.ciudad=proyecto.ciudad));

select * from proveedor
where not exists
(select proyecto.ciudad from proyecto
minus
select pieza.ciudad from ventas, pieza
where ventas.codpie=pieza.codpie and ventas.codpro=proveedor.codpro);

-- 3.26) Encontrar el número de envíos con más de 1000 unidades.

select count(*) from ventas where cantidad>1000;

-- 3.27) Mostrar el máximo peso.

select max(peso) from pieza;

-- 3.28) Mostrar el código de la pieza de máximo peso.

select codpie from pieza where peso=(select max(peso) from pieza);

-- 3.30) Muestra los códigos de proveedores que han hecho más de 3 envíos diferentes.

select codpro from proveedor
where (select count(*) from ventas where ventas.codpro=proveedor.codpro)>3;

-- 3.31) Mostrar la media de las cantidades vendidas por cada código de pieza junto con su nombre.

select ventas.codpie, pieza.nompie, avg(cantidad) from ventas, pieza
where ventas.codpie=pieza.codpie
group by ventas.codpie, pieza.nompie;

-- 3.32) Encontrar la cantidad media de ventas de la pieza 'P1' realizadas por cada proveedor.

select codpro, avg(cantidad) from ventas
where codpie='P1'
group by codprod;

-- 3.33) Encontrar la cantidad total de cada pieza enviada a cada proyecto.

select codpie, codpj, sum(cantidad) from ventas
group by codpie, codpj;

-- 3.35) Mostrar los nombres de proveedores tales que el total de sus ventas superen la cantidad de 1000 unidades.

select nompro from proveedor
where codpro in (select ventas.codpro from ventas
group by ventas.codpro
having sum(ventas.cantidad)>1000);

-- 3.36) Mostrar para cada pieza la cantidad máxima vendida.

select codpie, max(cantidad) from ventas
group by codpie;

-- 3.38) Encontrar la media de productos suministrados cada mes.

-- Considerando distintos los meses de distintos años
select to_char(fecha, 'MON-YYYY'), avg(cantidad)
from ventas
group by to_char(fecha, 'MON-YYYY');

-- Considerando iguales los meses de distintos años
select to_char(fecha, 'MON'), avg(cantidad)
from ventas
group by to_char(fecha, 'MON');

-- 3.42) Mostrar los códigos de aquellos proveedores que hayan superado las ventas totales realizadas por el proveedor 'S1'.

select s.codpro from proveedor s where
(select count(*) from ventas where ventas.codpro=s.codpro)
> (select count(*) from ventas where ventas.codpro='S1');

-- 3.43) Mostrar los mejores proveedores, entendiéndose como los que tienen mayores cantidades totales.

select proveedor.* from proveedor
where codpro in (select codpro from ventas group by codpro
having sum(cantidad) >= all
(select sum(cantidad) from ventas group by codpro));

-- 3.44) Mostrar los proveedores que venden piezas a todas las ciudades de los proyectos a los que suministra 'S3', sin incluirlo.

-- Entiendo que vender una pieza a una ciudad es vender la pieza a un proyecto de la ciudad.

select * from proveedor where codpro!='S3' and codpro in(
select distinct codpro from ventas v2
where not exists (
select j.ciudad from proyecto j natural join ventas v where v.codpro='S3'
and not exists (
select * from ventas v1 natural join proyecto j1 where v2.codpro=v1.codpro and j1.ciudad=j.ciudad)));

-- 3.45) Encontrar aquellos proveedores que hayan hecho al menos diez pedidos.

select * from proveedor where codpro in
(select codpro from ventas group by codpro having count(*)>=10);

-- 3.46) Encontrar aquellos proveedores que venden todas las piezas suministradas por S1.

select * from proveedor where
not exists(
select v1.codpie from ventas v1 where v1.codpro='S1'
minus
select v2.codpie from ventas v2 where v2.codpro=proveedor.codpro);

-- 3.47) Encontrar la cantidad total de piezas que ha vendido cada proveedor que cumple la condición de vender todas las piezas suministradas por S1.

select t.codpro, sum(cantidad) from 
(select * from proveedor where
not exists(
select v1.codpie from ventas v1 where v1.codpro='S1'
minus
select v2.codpie from ventas v2 where v2.codpro=proveedor.codpro)) t
natural join ventas group by t.codpro;

-- 3.48) Encontrar qué proyectos están suministrados por todos los proveedores que suministran la pieza P3.

select * from proyecto
where not exists(
select v.codpro from ventas v where v.codpie='P3'
minus
select v1.codpro from ventas v1 where v1.codpj=proyecto.codpj);

-- 3.49) Encontrar la cantidad media de piezas suministrada a aquellos proveedores que venden la pieza P3.

-- Cantidad media por cada proveedor que vende P3

select t.codpro, avg(cantidad)
from (select v.codpro from ventas v where v.codpie='P3') t, ventas v1
where t.codpro=v1.codpro
group by t.codpro;

-- Cantidad media de todos los proveedores que venden P3

select avg(cantidad)
from (select v.codpro from ventas v where v.codpie='P3') t, ventas v1
where t.codpro=v1.codpro;

-- 3.50) Nombres de los índices y sobre que tablas están montados, además de su propietario.

select index_name, table_name, owner from all_indexes;

-- 3.52) Mostrar para cada proveedor la media de productos suministrados cada año.

-- Media por proveedor y año
select codpro, to_char(fecha, 'yyyy'), avg(cantidad) from ventas
group by codpro, to_char(fecha, 'yyyy');

-- Media por proveedor de cantidad de piezas que vende cada año (que halla vendido al menos una)

create or replace view CantidadProveedorAnio(codpro, anio, cantidad) as
select codpro, to_char(fecha, 'yyyy'), sum(cantidad) from ventas
group by codpro, to_char(fecha, 'yyyy');

select codpro, avg(cantidad) from cantidadproveedoranio
group by codpro;

-- 3.53) Encontrar todos los proveedores que venden una pieza roja.
select * from proveedor
where codpro in
(select codpro from ventas natural join pieza where color='Rojo');

-- 3.54) Encontrar todos los proveedores que venden todas las piezas rojas.

select * from proveedor where codpro in
(select s.codpro from proveedor s
where not exists (
select codpie from pieza where color='Rojo'
minus
select codpie from ventas where ventas.codpro=s.codpro));
 
-- 3.55) Encontrar todos los proveedores tales que todas las piezas que venden son rojas.

select * from proveedor where codpro in
(select codpro from proveedor
minus
select codpro from ventas natural join pieza where pieza.color!='Rojo');

-- 3.56) Encontrar el nombre de aquellos proveedores que venden más de una pieza roja.

-- Entiendo que deben vender dos o más piezas rojas distintas.

select codpro from ventas, pieza
where ventas.codpie=pieza.codpie and color='Rojo'
group by codpro
having count(distinct pieza.codpie)>1;

-- 3.57) Encontrar todos los proveedores que vendiendo todas las piezas rojas cumplen la condición de que todas sus ventas son de más de 10 unidades.

select * from proveedor where codpro in (
(select s.codpro from proveedor s
where not exists (
select codpie from pieza where color='Rojo'
minus
select codpie from ventas where ventas.codpro=s.codpro))
intersect
(select s1.codpro from proveedor s1
where not exists
(select * from ventas where ventas.codpro=proveedor.codpro
and cantidad<=10))
);

-- 3.58) Coloca el status igual a 1 a aquellos proveedores que sólo suministran la pieza P1.

update proveedor
set status=1 where codpro in(
select codpro from ventas v
where not exists
(select * from ventas v1 where v1.codpro=v.codpro and v1.codpie!='P1'));

-- 3.59) Encuentra, de entre las piezas que no se han vendido en septiembre de 2009, las ciudades de aquellas que se han vendido en mayor cantidad durante Agosto de ese mismo año.

create or replace view PieNoSept2009 as select * from pieza where codpie in
(select codpie from pieza
minus
select codpie from ventas where to_char(fecha,'mm-yyyy')='09-2009');

create or replace view VentasAgos2009 as select * from ventas
where to_char(fecha,'mm-yyyy')='08-2009';

select ciudad from PieNoSept2009 p, VentasAgos2009 v
where p.codpie=v.codpie
group by p.codpie, ciudad
having sum(cantidad)=(select max(sum(cantidad)) from VentasAgos2009
where codpie in (select codpie from PieNoSept2009)
group by codpie);

-- Encontrar los proveedores que han hecho un mayor número de ventas a
-- proyectos que forman parte de la lista de proyectos que usan piezas
-- de todas las ciudades.

create or replace view ProyectosQueUsanPiezasDeTodasLasCiudades as
select * from proyecto j
where not exists(
select ciudad from pieza
minus
select p.ciudad from pieza p natural join ventas v where v.codpj=j.codpj);

create or replace view Proveedores1 as
select * from proveedor where codpro in
(select v.codpro from ventas v
where v.codpj in
(select codpj from ProyectosQueUsanPiezasDeTodasLasCiudades)
group by v.codpro
having count(*) >= all (select count(*) from ventas v1
where v1.codpj in
(select codpj from ProyectosQueUsanPiezasDeTodasLasCiudades)
group by v1.codpro);

-- Ahora encontrar los proveedores que han hecho el mayor y el segundo
-- mayor número de ventas a proyectos que forman parte de la lista de
-- proyectos que usan piezas de todas las ciudades.

select * from proveedor where codpro in
(select v.codpro from ventas v
where v.codpj in
(select codpj from ProyectosQueUsanPiezasDeTodasLasCiudades)
group by v.codpro
having count(*) >= all (select count(*) from ventas v1
where v1.codpj in 
(select codpj from ProyectosQueUsanPiezasDeTodasLasCiudades)
and v1.codpro not in (select codpro from Proveedores1)
group by v1.codpro);
