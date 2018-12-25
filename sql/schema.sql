-- Script para cargar el esquema y el contenido de la base de datos

create table proveedor(
codpro char(3) constraint codpro_no_nulo not null
constraint codpro_clave_primaria primary key,
nompro varchar2(30) constraint nompro_no_nulo not null,
status number constraint status_entre_1_y_10 check(status>=1 and status<=10),
ciudad varchar2(15));

create table pieza(
codpie char(3) constraint codpie_clave_primaria primary key,
nompie varchar2(10) constraint nompie_no_nulo not null,
color varchar2(10),
peso number(5,2) constraint peso_entre_0_y_100 check(peso>0 and peso<=100),
ciudad varchar2(15));

create table proyecto(
codpj char(3) constraint codpj_clave_primaria primary key,
nompj varchar2(20) constraint nompj_no_nulo not null,
ciudad varchar2(15));

create table ventas(
codpro constraint codpro_clave_externa_proveedor
references proveedor(codpro),
codpie constraint codpie_clave_externa_pieza
references pieza(codpie),
codpj constraint codpj_clave_externa_proyecto
references proyecto(codpj),
cantidad number(4),
constraint clave_primaria primary key (codpro, codpie, codpj));

alter table ventas add(fecha date);

insert into proveedor (codpro, nompro, status, ciudad) values('S1', 'Jose Fernandez', 2, 'Madrid');
insert into proveedor (codpro, nompro, status, ciudad) values('S2', 'Manuel Vidal', 1, 'Londres');
insert into proveedor (codpro, nompro, status, ciudad) values('S3', 'Luisa Gomez', 3, 'Lisboa');
insert into proveedor (codpro, nompro, status, ciudad) values('S4', 'Pedro Sanchez', 4, 'Paris');
insert into proveedor (codpro, nompro, status, ciudad) values('S5', 'Maria Reyes', 5, 'Roma');

insert into pieza(codpie, nompie, color, peso, ciudad) values('P1','Tuerca','Gris',2.5,'Madrid');
insert into pieza(codpie, nompie, color, peso, ciudad) values('P2','Tornillo','Rojo',1.25,'Paris');
insert into pieza(codpie, nompie, color, peso, ciudad) values('P3','Arandela','Blanco',3,'Londres');
insert into pieza(codpie, nompie, color, peso, ciudad) values('P4','Clavo','Gris',5.5,'Lisboa');
insert into pieza(codpie, nompie, color, peso, ciudad) values('P5','Alcayata','Blanco',10,'Roma');

insert into proyecto(codpj, nompj, ciudad) values('J1','Proyecto1','Londres');
insert into proyecto(codpj, nompj, ciudad) values('J2','Proyecto2','Londres');
insert into proyecto(codpj, nompj, ciudad) values('J3','Proyecto3','Paris');
insert into proyecto(codpj, nompj, ciudad) values('J4','Proyecto4','Roma');

insert into ventas (codpro, codpie, codpj, cantidad, fecha) values('S1', 'P1', 'J1', 150, to_date('18/09/1997','dd/mm/yyyy'));
insert into ventas (codpro, codpie, codpj, cantidad, fecha) values('S1', 'P1', 'J2', 100, to_date('06/05/1996','dd/mm/yyyy'));
insert into ventas (codpro, codpie, codpj, cantidad, fecha) values('S1', 'P1', 'J3', 500, to_date('06/05/1996','dd/mm/yyyy'));
insert into ventas (codpro, codpie, codpj, cantidad, fecha) values('S1', 'P2', 'J1', 200, to_date('22/07/1995','dd/mm/yyyy'));
insert into ventas (codpro, codpie, codpj, cantidad, fecha) values('S2', 'P2', 'J2', 15, to_date('23/11/2004','dd/mm/yyyy'));
insert into ventas (codpro, codpie, codpj, cantidad, fecha) values('S4', 'P2', 'J3', 1700, to_date('28/11/2000','dd/mm/yyyy'));
insert into ventas (codpro, codpie, codpj, cantidad, fecha) values('S1', 'P3', 'J1', 800, to_date('22/07/1995','dd/mm/yyyy'));
insert into ventas (codpro, codpie, codpj, cantidad, fecha) values('S5', 'P3', 'J2', 30, to_date('21/01/2004','dd/mm/yyyy'));
insert into ventas (codpro, codpie, codpj, cantidad, fecha) values('S1', 'P4', 'J1', 10, to_date('22/07/1995','dd/mm/yyyy'));
insert into ventas (codpro, codpie, codpj, cantidad, fecha) values('S1', 'P4', 'J3', 250, to_date('09/03/1994','dd/mm/yyyy'));
insert into ventas (codpro, codpie, codpj, cantidad, fecha) values('S2', 'P5', 'J2', 300, to_date('23/11/2004','dd/mm/yyyy'));
insert into ventas (codpro, codpie, codpj, cantidad, fecha) values('S2', 'P2', 'J1', 4500, to_date('15/08/2004','dd/mm/yyyy'));
insert into ventas (codpro, codpie, codpj, cantidad, fecha) values('S3', 'P1', 'J1', 90, to_date('09/06/2004','dd/mm/yyyy'));
insert into ventas (codpro, codpie, codpj, cantidad, fecha) values('S3', 'P2', 'J1', 190, to_date('12/04/2002','dd/mm/yyyy'));
insert into ventas (codpro, codpie, codpj, cantidad, fecha) values('S3', 'P5', 'J3', 20, to_date('28/11/2000','dd/mm/yyyy'));
insert into ventas (codpro, codpie, codpj, cantidad, fecha) values('S4', 'P5', 'J1', 15, to_date('12/04/2002','dd/mm/yyyy'));
insert into ventas (codpro, codpie, codpj, cantidad, fecha) values('S4', 'P3', 'J1', 100, to_date('12/04/2002','dd/mm/yyyy'));
insert into ventas (codpro, codpie, codpj, cantidad, fecha) values('S4', 'P1', 'J3', 1500, to_date('26/01/2003','dd/mm/yyyy'));
insert into ventas (codpro, codpie, codpj, cantidad, fecha) values('S1', 'P4', 'J4', 290, to_date('09/03/1994','dd/mm/yyyy'));
insert into ventas (codpro, codpie, codpj, cantidad, fecha) values('S1', 'P2', 'J4', 175, to_date('09/03/1994','dd/mm/yyyy'));
insert into ventas (codpro, codpie, codpj, cantidad, fecha) values('S5', 'P1', 'J4', 400, to_date('21/01/2004','dd/mm/yyyy'));
insert into ventas (codpro, codpie, codpj, cantidad, fecha) values('S5', 'P3', 'J3', 400, to_date('21/01/2004','dd/mm/yyyy'));
