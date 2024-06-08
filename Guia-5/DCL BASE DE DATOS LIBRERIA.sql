-- DCL BASE DE DATOS LIBRERIA -- 

use Libreria;

-- CREACION DE ROLES
create role if not exists 'SysAdmin';
create role if not exists 'Gerente';
create role if not exists 'Vendedor';
create role if not exists 'Cajero';
create role if not exists 'Marketing';
create role if not exists 'Bodeguero';
create role if not exists 'RRHH';

-- ASIGNACION DE PRIVILEGIOS A ROLES
-- Administrador
grant all on Libreria.* TO 'SysAdmin';
-- Gerente
grant select, insert, update, delete on libreria.direcciones to Gerente;
grant select on libreria.departamentos to Gerente;
grant select on libreria.municipios to Gerente;
grant select on libreria.distritos to Gerente;
-- Vendedor
grant select, insert, update, delete on libreria.direcciones to Vendedor;
grant select on libreria.departamentos to Vendedor;
grant select on libreria.municipios to Vendedor;
grant select on libreria.distritos to Vendedor;
-- Cajero
grant select, insert, update, delete on libreria.direcciones to Cajero;
grant select on libreria.departamentos to Cajero;
grant select on libreria.municipios to Cajero;
grant select on libreria.distritos to Cajero;
-- Marketing
grant select, insert, update, delete on libreria.direcciones to Marketing;
grant select on libreria.departamentos to Marketing;
grant select on libreria.municipios to Marketing;
grant select on libreria.distritos to Marketing;
-- Bodeguero
grant select, insert, update, delete on libreria.direcciones to Bodeguero;
grant select on libreria.departamentos to Bodeguero;
grant select on libreria.municipios to Bodeguero;
grant select on libreria.distritos to Bodeguero;
-- RRHH
grant select, insert, update, delete on libreria.direcciones to RRHH;
grant select, insert, update, delete on libreria.cargos to RRHH;
grant select, insert, update, delete on libreria.empleados to RRHH;
grant select on libreria.usuarios to RRHH;
grant select on libreria.roles to RRHH;
grant select on libreria.departamentos to RRHH;
grant select on libreria.municipios to RRHH;
grant select on libreria.distritos to RRHH;

-- CREACION DE USUARIOS
create user if not exists 'admin_juanrodas'@'localhost' 
identified with sha256_password by '1234' 
password expire interval 180 day;

create user if not exists 'dir_diegosanchez'@'localhost' 
identified with sha256_password by '1234' 
password expire interval 180 day;

create user if not exists 'doc_rauldvalle'@'localhost' 
identified with sha256_password by '1234' 
password expire interval 180 day;

create user if not exists 'rrhh_maryperez'@'localhost' 
identified with sha256_password by '1234' 
password expire interval 180 day;

-- Consultar roles y usuarios
select * from mysql.user;

-- VINCULAR USUARIOS A ROLES
grant SysAdmin TO 'admin_juanrodas'@'localhost';
grant Gerente TO 'dir_diegosanchez'@'localhost'; 
grant Vendedor TO 'doc_rauldvalle'@'localhost';
grant RRHH TO 'rrhh_maryperez'@'localhost';

-- CONSULTAR PERMISOS POR ROL Y USUARIOS
-- Roles
show grants for 'SysAdmin';
show grants for 'Gerente';
show grants for 'Vendedor';
show grants for 'RRHH';
-- Usuarios
show grants for 'admin_juanrodas'@'localhost';
show grants for 'dir_diegosanchez'@'localhost'; 
show grants for 'doc_rauldvalle'@'localhost';
show grants for 'rrhh_maryperez'@'localhost';