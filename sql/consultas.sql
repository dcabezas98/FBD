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

-- 3.27) Mostrar el máximo peso.

-- 3.28) Mostrar el código de la pieza de máximo peso.

-- 3.30) Muestra los códigos de proveedores que han hecho más de envíos diferentes.

-- 3.31) Mostrar la media de las cantidades vendidas por cada código de pieza junto con su nombre.

-- 3.32) Encontrar la cantidad media de ventas de la pieza 'P1' realizadas por cada proveedor.

-- 3.33) Encontrar la cantidad total de cada pieza enviada a cada proyecto.

-- 3.35) Mostrar los nombres de proveedores tales que el total de sus ventas superen la cantidad de 1000 unidades.

-- 3.36) Mostrar para cada pieza la cantidad máxima vendida.

-- 3.38) Encontrar la media de productos suministrados cada mes.
