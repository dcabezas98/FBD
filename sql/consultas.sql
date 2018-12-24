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

-- 3.13) Encontrar parejas de proveedores que no viven en la misma ciudad.

-- 3.14) Encuentra las piezas con máximo peso.

-- 3.15) Mostar las piezas vendidas por los proveedores de Madrid.

-- 3.16) Encuentra la ciudad y los códigos de las piezas suministradas a cualquier proyecto por un proveedor que está en la misma ciudad donde está el proyecto.

-- 3.17) Listar las ventas ordenadas por cantidad, si algunas ventas coinciden en la cantidad se ordenan en función de la fecha de manera descendente.

-- 3.19) Mostrar las piezas vendidas por los proveedores de Madrid. (Fragmentando la consulta con la ayuda del operador IN).

-- 3.20) Encuentra los proyectos que están en una ciudad donde se fabrica alguna pieza.

-- 3.21) Encuentra los códigos de aquellos proyectos que no utilizan ninguna pieza roja que esté suministrada por un proveedor de Londres.

-- 3.22) Muestra el código de las piezas cuyo peso es mayor que el peso de cualquier 'tornillo'.

-- 3.23) Encuentra las piezas con peso máximo. (Usando < | <= | > | >= ANY|ALL)

-- 3.24) Encontrar los códigos de las piezas suministradas a todos los proyectos localizados en Londres.

-- 3.25) Encontrar aquellos proveedores que envían piezas procedentes de todas las ciudades donde hay un proyecto.

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
