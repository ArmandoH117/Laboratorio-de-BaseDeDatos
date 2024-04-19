create database if not exists Libreria;
use Libreria;

CREATE TABLE departamentos(
	idDepartamento CHAR(2) PRIMARY KEY,
	nombreDepartamento VARCHAR(25) NOT NULL
);
CREATE TABLE municipios(
	idMunicipio CHAR(3) PRIMARY KEY ,
	nombreMunicipio VARCHAR(30) NOT NULL,
	idDepartamento CHAR(2) NOT NULL
);
CREATE TABLE distritos(
	idDistrito CHAR(5) PRIMARY KEY ,
	nombreDistrito VARCHAR(45) NOT NULL,
	idMunicipio CHAR(3) NOT NULL
);
CREATE TABLE direcciones (
    idDireccion INT PRIMARY KEY AUTO_INCREMENT,
    linea1 VARCHAR(100) NOT NULL,
    linea2 VARCHAR(50),
    codigoPostal VARCHAR(7),
    idDistrito CHAR(5) NOT NULL
);
CREATE TABLE sucursales(
	idSucursal INT PRIMARY KEY AUTO_INCREMENT,
	nombreSucursal VARCHAR(100) NOT NULL,
	numeroEmpleado VARCHAR(100) NOT NULL,
	idDireccion INT NOT NULL
);
create table cargos(
	idCargo int primary key auto_increment,
    nombreCargo varchar(50) not null
);
create table empleados(
	idEmpleado int primary key auto_increment,
    nombreEmpleado varchar(100) not null,
    apellidoEmpleado varchar(100) not null,
    fechaDeNacimientoEmpleado DATE not null,
    generoEmpleado enum('FEMENINO','MASCULINO') not null,
    duiEmpleado char(12) not null,
    correoEmpleado varchar(50),
    numeroTelefonoEmpleado char(10) not null,
    numeroSucursalEmpleado int not null,
    numSeguroSocialEmpleado int not null,
    numAFP int not null,
    idDireccion INT NOT NULL ,
    idCargo INT NOT NULL,
    idSucursal INT NOT NULL
);
create table ventas(
	idVenta int primary key auto_increment,
    montoTotal decimal not null,
    fechaVenta date not null,
    idEmpleado INT NOT NULL ,
    idCliente INT NOT NULL ,
    idMetodoPago INT NOT NULL
);
create table metodosPago(
	idMetodoPago int primary key auto_increment,
    nombreMetodoPago varchar(50) not null
);
create table clientes(
	idCliente int primary key auto_increment,
    nombresClientes varchar(100) not null,
    apellidosClientes varchar(100) not null,
    duiCliente char(12) not null,
    telefonoCliente varchar(15),
    correoCliente varchar(50)
);
CREATE TABLE inventarios(
	idInventario INT PRIMARY KEY AUTO_INCREMENT,
	estante VARCHAR(45) NOT NULL,
	pasillo VARCHAR(45) NOT NULL,
	stock VARCHAR(45) NOT NULL
);
CREATE TABLE editoriales(
	idEditorial INT PRIMARY KEY AUTO_INCREMENT,
	nombreEditorial VARCHAR(45) NOT NULL,
	idDireccion INT NOT NULL
);
CREATE TABLE libros(
	idLibro INT PRIMARY KEY AUTO_INCREMENT,
	titulo VARCHAR(45) NOT NULL,
	fechaPublicacion DATE NOT NULL,
	precioUnitario DECIMAL NOT NULL,
	idInventario INT NOT NULL,
	idEditorial INT NOT NULL
);
create table pedidos(
	idPedido int primary key auto_increment,
    fechaPedido date not null,
    cantidadTotal int not null,
    idEditorial INT NOT NULL,
    idEmpleado INT NOT NULL
);
create table detallePedidos(
	idDetallePedido int primary key auto_increment,
    cantidadLibros int not null,
    idLibro INT NOT NULL,
    idPedido INT NOT NULL
);
create table detalleVentas(
	idDetalleVenta int primary key auto_increment,
    idLibro INT NOT NULL,
	idVenta INT NOT NULL
);
create table facturasVentas(
	idFacturaVenta int primary key auto_increment,
    fechaFacturaVenta date not null,
    totalPagarVenta decimal not null,
    ivaFacturaVenta decimal,
    creditoFiscalFacturaVenta varchar(45),
    idDetalleVenta INT NOT NULL
);
create table facturasCompras(
	idFacturaCompra int primary key auto_increment,
    fechaFacturaCompra date not null,
    totalPagarCompra decimal not null,
    ivaFacturaCompra decimal,
    creditoFiscalFacturaCompra varchar(45),
    idDetallePedido INT NOT NULL
);
CREATE TABLE generos(
	idGenero INT PRIMARY KEY AUTO_INCREMENT,
	generoLiterario VARCHAR(45) NOT NULL
);
CREATE TABLE detallesGenerosLibros(
	idGenero INT NOT NULL,
	idLibro INT NOT NULL
);
CREATE TABLE detallesAutoresLibros(
	idAutor INT NOT NULL,
	idLibro INT NOT NULL
);
CREATE TABLE autores(
	idAutor INT PRIMARY KEY AUTO_INCREMENT,
	nombresAutor VARCHAR(100) NOT NULL,
	apellidosAutor VARCHAR(100) NOT NULL,
	nacionalidad VARCHAR(45) NOT NULL
);
-- Llaves foraneas de direcciones
alter table municipios add foreign key (idDepartamento) references departamentos(idDepartamento);
alter table distritos add foreign key (idMunicipio) references municipios(idMunicipio);
alter table direcciones add foreign key (idDistrito) references distritos(idDistrito);
alter table sucursales add foreign key (idDireccion) references direcciones(idDireccion);
-- llave foranea empleados
alter table empleados add foreign key (idDireccion) references direcciones(idDireccion);
alter table empleados add foreign key (idCargo) references cargos(idCargo);
alter table empleados add foreign key (idSucursal) references sucursales(idSucursal);
-- llave foranea ventas
alter table ventas add foreign key (idEmpleado) references empleados(idEmpleado);
alter table ventas add foreign key (idCliente) references clientes(idCliente);
alter table ventas add foreign key (idMetodoPago) references metodosPago(idMetodoPago);
-- llave foranea editoreales 
alter table editoriales add foreign key (idDireccion) references direcciones(idDireccion);
-- llave foranea libros
alter table libros add foreign key (idInventario) references inventarios(idInventario);
alter table libros add foreign key (idEditorial) references editoriales(idEditorial);
-- llave foranea pedido
alter table pedidos add foreign key (idEditorial)  references editoriales(idEditorial);
alter table pedidos add foreign key (idEmpleado) references empleados(idEmpleado);
-- llave foranea detallePedidos
alter table detallePedidos add foreign key (idLibro) references libros(idLibro);
alter table detallePedidos add foreign key (idPedido) references pedidos(idPedido);
-- llave foranea detalleVentas
alter table detalleVentas add foreign key (idLibro) references libros(idLibro);
alter table detalleVentas add foreign key (idVenta) references ventas(idVenta);
-- llave foranea facturasVentas
alter table facturasVentas add foreign key (idDetalleVenta) references detalleVentas(idDetalleVenta);
-- llave foranea facturasCompras
alter table facturasCompras add foreign key (idDetallePedido) references detallePedidos(idDetallePedido);
-- llave detallesGenerosLibros
alter table detallesGenerosLibros add foreign key (idGenero) references generos(idGenero);
alter table detallesGenerosLibros add foreign key (idLibro) references libros(idLibro);
-- llave detallesAutoresLibros
alter table detallesAutoresLibros add foreign key (idAutor) references autores(idAutor);
alter table detallesAutoresLibros add foreign key (idLibro) references libros(idLibro);

-- Tablas de direccion
insert into departamentos values
-- idDepartamento, departamento 
	('AH', 'Ahuachapán'),
	('CA', 'Cabañas'),
	('CH', 'Chalatenango'),
	('CU', 'Cuscatlán'),
	('LL', 'La Libertad'),
	('LP', 'La Paz'),
	('LU', 'La Unión'),
	('MO', 'Morazán'),
	('SA', 'Santa Ana'),
	('SM', 'San Miguel'),
	('SS', 'San Salvador'),
	('SV', 'San Vicente'),
	('SO', 'Sonsonate'),
	('US', 'Usulután');
    
    insert into municipios values
-- idMunicipio, municipio, idDepartamento
	('AHN', 'Ahuachapán Norte', 'AH'),
	('AHC', 'Ahuachapán Centro', 'AH'),
	('AHS', 'Ahuachapán Sur', 'AH'),
	('CAE', 'Cabañas Este', 'CA'),
	('CAO', 'Cabañas Oeste', 'CA'),
	('CHN', 'Chalatenango Norte', 'CH'),
	('CHC', 'Chalatenango Centro', 'CH'),
	('CHS', 'Chalatenango Sur', 'CH'),
	('CUN', 'Cuscatlán Norte', 'CU'),
	('CUS', 'Cuscatlán Sur', 'CU'),
	('LLN', 'La Libertad Norte', 'LL'),
	('LLC', 'La Libertad Centro', 'LL'),
	('LLO', 'La Libertad Oeste', 'LL'),
	('LLE', 'La Libertad Este', 'LL'),
	('LLS', 'La Libertad Sur', 'LL'),
	('LLT', 'La Libertad Costa', 'LL'),
	('LPO', 'La Paz Oeste', 'LP'),
	('LPC', 'La Paz Centro', 'LP'),
	('LPE', 'La Paz Este', 'LP'),
	('LUN', 'La Unión Norte', 'LU'),
	('LUS', 'La Unión Sur', 'LU'),
	('MON', 'Morazán Norte', 'MO'),
	('MOS', 'Morazán Sur', 'MO'),
	('SAN', 'Santa Ana Norte', 'SA'),
	('SAC', 'Santa Ana Centro', 'SA'),
	('SAE', 'Santa Ana Este', 'SA'),
	('SAO', 'Santa Ana Oeste', 'SA'),
	('SMN', 'San Miguel Norte', 'SM'),
	('SMC', 'San Miguel Centro', 'SM'),
	('SMO', 'San Miguel Oeste', 'SM'),
	('SSN', 'San Salvador Norte', 'SS'),
	('SSO', 'San Salvador Oeste', 'SS'),
	('SSE', 'San Salvador Este', 'SS'),
	('SSC', 'San Salvador Centro', 'SS'),
	('SSS', 'San Salvador Sur', 'SS'),
	('SVN', 'San Vicente Norte', 'SV'),
	('SVS', 'San Vicente Sur', 'SV'),
	('SON', 'Sonsonate Norte', 'SO'),
	('SOC', 'Sonsonate Centro', 'SO'),
	('SOE', 'Sonsonate Este', 'SO'),
	('SOO', 'Sonsonate Oeste', 'SO'),
	('USN', 'Usulután Norte', 'US'),
	('USE', 'Usulután Este', 'US'),
	('USO', 'Usulután Oeste', 'US');
    
    insert into distritos values
-- idDistrito, distrito, idMunicipio
-- Ahuachapan
	('AHN01', 'Atiquizaya', 'AHN'),
	('AHN02', 'El Refugio', 'AHN'),
	('AHN03', 'San Lorenzo', 'AHN'),
	('AHN04', 'Turín', 'AHN'),
	('AHC01', 'Ahuachapán', 'AHC'),
	('AHC02', 'Apaneca', 'AHC'),
	('AHC03', 'Concepción de Ataco', 'AHC'),
	('AHC04', 'Tacuba', 'AHC'),
	('AHS01', 'Guaymango', 'AHS'),
	('AHS02', 'Jujutla', 'AHS'),
	('AHS03', 'San Francisco Menéndez', 'AHS'),
	('AHS04', 'San Pedro Puxtla', 'AHS'),
-- Cabañas
	('CAE01', 'Sensuntepeque', 'CAE'),
	('CAE02', 'Victoria', 'CAE'),
	('CAE03', 'Dolores', 'CAE'),
	('CAE04', 'Guacotecti', 'CAE'),
	('CAE05', 'San Isidro', 'CAE'),
	('CAO01', 'Ilobasco', 'CAO'),
	('CAO02', 'Tejutepeque', 'CAO'),
	('CAO03', 'Jutiapa', 'CAO'),
	('CAO04', 'Cinquera', 'CAO'),
-- Chalatenango
	('CHN01', 'La Palma', 'CHN'),
	('CHN02', 'Citalá', 'CHN'),
	('CHN03', 'San Ignacio', 'CHN'),
	('CHC01', 'Nueva Concepción', 'CHC'),
	('CHC02', 'Tejutla', 'CHC'),
	('CHC03', 'La Reina', 'CHC'),
	('CHC04', 'Agua Caliente', 'CHC'),
	('CHC05', 'Dulce Nombre de María', 'CHC'),
	('CHC06', 'El Paraíso', 'CHC'),
	('CHC07', 'San Fernando', 'CHC'),
	('CHC08', 'San Francisco Morazán', 'CHC'),
	('CHC09', 'San Rafael', 'CHC'),
	('CHC10', 'Santa Rita', 'CHC'),
	('CHS01', 'Chalatenango', 'CHS'),
	('CHS02', 'Arcatao', 'CHS'),
	('CHS03', 'Azacualpa', 'CHS'),
	('CHS04', 'Comalapa', 'CHS'),
	('CHS05', 'Concepción Quezaltepeque', 'CHS'),
	('CHS06', 'El Carrizal', 'CHS'),
	('CHS07', 'La Laguna', 'CHS'),
	('CHS08', 'Las Vueltas', 'CHS'),
	('CHS09', 'Nombre de Jesús', 'CHS'),
	('CHS10', 'Nueva Trinidad', 'CHS'),
	('CHS11', 'Ojos de Agua', 'CHS'),
	('CHS12', 'Potonico', 'CHS'),
	('CHS13', 'San Antonio de La Cruz', 'CHS'),
	('CHS14', 'San Antonio Los Ranchos', 'CHS'),
	('CHS15', 'San Francisco Lempa', 'CHS'),
	('CHS16', 'San Isidro Labrador', 'CHS'),
	('CHS17', 'San José Cancasque', 'CHS'),
	('CHS18', 'San Miguel de Mercedes', 'CHS'),
	('CHS19', 'San José Las Flores', 'CHS'),
	('CHS20', 'San Luis del Carmen', 'CHS'),
-- Cuscatlán
	('CUN01', 'Suchitoto', 'CUN'),
	('CUN02', 'San José Guayabal', 'CUN'),
	('CUN03', 'Oratorio de Concepción', 'CUN'),
	('CUN04', 'San Bartolomé Perulapía', 'CUN'),
	('CUN05', 'San Pedro Perulapán', 'CUN'),
	('CUS01', 'Cojutepeque', 'CUS'),
	('CUS02', 'San Rafael Cedros', 'CUS'),
	('CUS03', 'Candelaria', 'CUS'),
	('CUS04', 'Monte San Juan', 'CUS'),
	('CUS05', 'El Carmen', 'CUS'),
	('CUS06', 'San Cristobal', 'CUS'),
	('CUS07', 'Santa Cruz Michapa', 'CUS'),
	('CUS08', 'San Ramón', 'CUS'),
	('CUS09', 'El Rosario', 'CUS'),
	('CUS10', 'Santa Cruz Analquito', 'CUS'),
	('CUS11', 'Tenancingo', 'CUS'),
-- La Libertad
	('LLN01', 'Quezaltepeque', 'LLN'),
	('LLN02', 'San Matías', 'LLN'),
	('LLN03', 'San Pablo Tacachico', 'LLN'),
	('LLC01', 'San Juan Opico', 'LLC'),
	('LLC02', 'Ciudad Arce', 'LLC'),
	('LLO01', 'Colón', 'LLO'),
	('LLO02', 'Jayaque', 'LLO'),
	('LLO03', 'Sacacoyo', 'LLO'),
	('LLO04', 'Tepecoyo', 'LLO'),
	('LLO05', 'Talnique', 'LLO'),
	('LLE01', 'Antiguo Cuscatlán', 'LLE'),
	('LLE02', 'Huizúcar', 'LLE'),
	('LLE03', 'Nuevo Cuscatlán', 'LLE'),
	('LLE04', 'San José Villanueva', 'LLE'),
	('LLE05', 'Zaragoza', 'LLE'),
	('LLS01', 'Comasagua', 'LLS'),
	('LLS02', 'Santa Tecla', 'LLS'),
	('LLT01', 'Chiltiupán', 'LLT'),
	('LLT02', 'Jicalapa', 'LLT'),
	('LLT03', 'La Libertad', 'LLT'),
	('LLT04', 'Tamanique', 'LLT'),
	('LLT05', 'Teotepeque', 'LLT'),
-- La Paz
	('LPO01', 'Cuyultitan', 'LPO'),
	('LPO02', 'Olocuilta', 'LPO'),
	('LPO03', 'San Juan Talpa', 'LPO'),
	('LPO04', 'San Luis Talpa', 'LPO'),
	('LPO05', 'San Pedro Masahuat', 'LPO'),
	('LPO06', 'Tapalhuaca', 'LPO'),
	('LPO07', 'San Francisco Chinameca', 'LPO'),
	('LPC01', 'El Rosario', 'LPC'),
	('LPC02', 'Jerusalén', 'LPC'),
	('LPC03', 'Mercedes La Ceiba', 'LPC'),
	('LPC04', 'Paraíso de Osorio', 'LPC'),
	('LPC05', 'San Antonio Masahuat', 'LPC'),
	('LPC06', 'San Emigdio', 'LPC'),
	('LPC07', 'San Juan Tepezontes', 'LPC'),
	('LPC08', 'San Luís La Herradura', 'LPC'),
	('LPC09', 'San Miguel Tepezontes', 'LPC'),
	('LPC10', 'San Pedro Nonualco', 'LPC'),
	('LPC11', 'Santa María Ostuma', 'LPC'),
	('LPC12', 'Santiago Nonualco', 'LPC'),
	('LPE01', 'San Juan Nonualco', 'LPE'),
	('LPE02', 'San Rafael Obrajuelo', 'LPE'),
	('LPE03', 'Zacatecoluca', 'LPE'),
-- La Unión
	('LUN01', 'Anamorós', 'LUN'),
	('LUN02', 'Bolivar', 'LUN'),
	('LUN03', 'Concepción de Oriente', 'LUN'),
	('LUN04', 'El Sauce', 'LUN'),
	('LUN05', 'Lislique', 'LUN'),
	('LUN06', 'Nueva Esparta', 'LUN'),
	('LUN07', 'Pasaquina', 'LUN'),
	('LUN08', 'Polorós', 'LUN'),
	('LUN09', 'San José La Fuente', 'LUN'),
	('LUN10', 'Santa Rosa de Lima', 'LUN'),
	('LUS01', 'Conchagua', 'LUS'),
	('LUS02', 'El Carmen', 'LUS'),
	('LUS03', 'Intipucá', 'LUS'),
	('LUS04', 'La Unión', 'LUS'),
	('LUS05', 'Meanguera del Golfo', 'LUS'),
	('LUS06', 'San Alejo', 'LUS'),
	('LUS07', 'Yayantique', 'LUS'),
	('LUS08', 'Yucuaiquín', 'LUS'),
-- Morazán
	('MON01', 'Arambala', 'MON'),
	('MON02', 'Cacaopera', 'MON'),
	('MON03', 'Corinto', 'MON'),
	('MON04', 'El Rosario', 'MON'),
	('MON05', 'Joateca', 'MON'),
	('MON06', 'Jocoaitique', 'MON'),
	('MON07', 'Meanguera', 'MON'),
	('MON08', 'Perquín', 'MON'),
	('MON09', 'San Fernando', 'MON'),
	('MON10', 'San Isidro', 'MON'),
	('MON11', 'Torola', 'MON'),
	('MOS01', 'Chilanga', 'MOS'),
	('MOS02', 'Delicias de Concepción', 'MOS'),
	('MOS03', 'El Divisadero', 'MOS'),
	('MOS04', 'Gualococti', 'MOS'),
	('MOS05', 'Guatajiagua', 'MOS'),
	('MOS06', 'Jocoro', 'MOS'),
	('MOS07', 'Lolotiquillo', 'MOS'),
	('MOS08', 'Osicala', 'MOS'),
	('MOS09', 'San Carlos', 'MOS'),
	('MOS10', 'San Francisco Gotera', 'MOS'),
	('MOS11', 'San Simón', 'MOS'),
	('MOS12', 'Sensembra', 'MOS'),
	('MOS13', 'Sociedad', 'MOS'),
	('MOS14', 'Yamabal', 'MOS'),
	('MOS15', 'Yoloaiquín', 'MOS'),
-- Santa Ana
	('SAN01', 'Masahuat', 'SAN'),
	('SAN02', 'Metapán', 'SAN'),
	('SAN03', 'Santa Rosa Guachipilín', 'SAN'),
	('SAN04', 'Texistepeque', 'SAN'),
	('SAC01', 'Santa Ana', 'SAC'),
	('SAE01', 'Coatepeque', 'SAE'),
	('SAE02', 'El Congo', 'SAE'),
	('SAO01', 'Candelaria de la Frontera', 'SAO'),
	('SAO02', 'Chalchuapa', 'SAO'),
	('SAO03', 'El Porvenir', 'SAO'),
	('SAO04', 'San Antonio Pajonal', 'SAO'),
	('SAO05', 'San Sebastián Salitrillo', 'SAO'),
	('SAO06', 'Santiago de La Frontera', 'SAO'),
-- San Miguel
	('SMN01', 'Ciudad Barrios', 'SMN'),
	('SMN02', 'Sesori', 'SMN'),
	('SMN03', 'Nuevo Edén de San Juan', 'SMN'),
	('SMN04', 'San Gerardo', 'SMN'),
	('SMN05', 'San Luis de La Reina', 'SMN'),
	('SMN06', 'Carolina', 'SMN'),
	('SMN07', 'San Antonio del Mosco', 'SMN'),
	('SMN08', 'Chapeltique', 'SMN'),
	('SMC01', 'San Miguel', 'SMC'),
	('SMC02', 'Comacarán', 'SMC'),
	('SMC03', 'Uluazapa', 'SMC'),
	('SMC04', 'Moncagua', 'SMC'),
	('SMC05', 'Quelepa', 'SMC'),
	('SMC06', 'Chirilagua', 'SMC'),
	('SMO01', 'Chinameca', 'SMO'),
	('SMO02', 'Nueva Guadalupe', 'SMO'),
	('SMO03', 'Lolotique', 'SMO'),
	('SMO04', 'San Jorge', 'SMO'),
	('SMO05', 'San Rafael Oriente', 'SMO'),
	('SMO06', 'El Tránsito', 'SMO'),
-- San Salvador
	('SSN01', 'Aguilares', 'SSN'),
	('SSN02', 'El Paisnal', 'SSN'),
	('SSN03', 'Guazapa', 'SSN'),
	('SSO01', 'Apopa', 'SSO'),
	('SSO02', 'Nejapa', 'SSO'),
	('SSE01', 'Ilopango', 'SSE'),
	('SSE02', 'San Martín', 'SSE'),
	('SSE03', 'Soyapango', 'SSE'),
	('SSE04', 'Tonacatepeque', 'SSE'),
	('SSC01', 'Ayutuxtepeque', 'SSC'),
	('SSC02', 'Mejicanos', 'SSC'),
	('SSC03', 'San Salvador', 'SSC'),
	('SSC04', 'Cuscatancingo', 'SSC'),
	('SSC05', 'Ciudad Delgado', 'SSC'),
	('SSS01', 'Panchimalco', 'SSS'),
	('SSS02', 'Rosario de Mora', 'SSS'),
	('SSS03', 'San Marcos', 'SSS'),
	('SSS04', 'Santo Tomás', 'SSS'),
	('SSS05', 'Santiago Texacuangos', 'SSS'),
-- San Vicente
	('SVN01', 'Apastepeque', 'SVN'),
	('SVN02', 'Santa Clara', 'SVN'),
	('SVN03', 'San Ildefonso', 'SVN'),
	('SVN04', 'San Esteban Catarina', 'SVN'),
	('SVN05', 'San Sebastián', 'SVN'),
	('SVN06', 'San Lorenzo', 'SVN'),
	('SVN07', 'Santo Domingo', 'SVN'),
	('SVS01', 'San Vicente', 'SVS'),
	('SVS02', 'Guadalupe', 'SVS'),
	('SVS03', 'Verapaz', 'SVS'),
	('SVS04', 'Tepetitán', 'SVS'),
	('SVS05', 'Tecoluca', 'SVS'),
	('SVS06', 'San Cayetano Istepeque', 'SVS'),
-- Sonsonate
	('SON01', 'Juayúa', 'SON'),
	('SON02', 'Nahuizalco', 'SON'),
	('SON03', 'Salcoatitán', 'SON'),
	('SON04', 'Santa Catarina Masahuat', 'SON'),
	('SOC01', 'Sonsonate', 'SOC'),
	('SOC02', 'Sonzacate', 'SOC'),
	('SOC03', 'Nahulingo', 'SOC'),
	('SOC04', 'San Antonio del Monte', 'SOC'),
	('SOC05', 'Santo Domingo de Guzmán', 'SOC'),
	('SOE01', 'Izalco', 'SOE'),
	('SOE02', 'Armenia', 'SOE'),
	('SOE03', 'Caluco', 'SOE'),
	('SOE04', 'San Julián', 'SOE'),
	('SOE05', 'Cuisnahuat', 'SOE'),
	('SOE06', 'Santa Isabel Ishuatán', 'SOE'),
	('SOO01', 'Acajutla', 'SOO'),
-- Usulután
	('USN01', 'Santiago de María', 'USN'),
	('USN02', 'Alegría', 'USN'),
	('USN03', 'Berlín', 'USN'),
	('USN04', 'Mercedes Umaña', 'USN'),
	('USN05', 'Jucuapa', 'USN'),
	('USN06', 'El triunfo', 'USN'),
	('USN07', 'Estanzuelas', 'USN'),
	('USN08', 'San Buenaventura', 'USN'),
	('USN09', 'Nueva Granada', 'USN'),
	('USE01', 'Usulután', 'USE'),
	('USE02', 'Jucuarán', 'USE'),
	('USE03', 'San Dionisio', 'USE'),
	('USE04', 'Concepción Batres', 'USE'),
	('USE05', 'Santa María', 'USE'),
	('USE06', 'Ozatlán', 'USE'),
	('USE07', 'Tecapán', 'USE'),
	('USE08', 'Santa Elena', 'USE'),
	('USE09', 'California', 'USE'),
	('USE10', 'Ereguayquín', 'USE'),
	('USO01', 'Jiquilisco', 'USO'),
	('USO02', 'Puerto El Triunfo', 'USO'),
	('USO03', 'San Agustín', 'USO'),
	('USO04', 'San Francisco Javier', 'USO');
    
    insert into direcciones (linea1, linea2, idDistrito, codigoPostal) values
	('Col Madera, Calle 1, #1N', 'Frente al parque', 'SON02', '02311'),  -- 1					
	('Barrio El Caldero, Av 2, #2I', 'Frente al amate', 'SOE01', '02306'), -- 2
	('Res El Cangrejo, Av 3, #3A', 'Frente a la playa', 'SOO01', '02302'), -- 3
	('Barrio El Centro, Av 4, #4S', 'Frente a catedral', 'SOC01', '02301'), -- 4
	('Col La Frontera, Calle 5, #5G', 'Km 10', 'AHS03', '02113'), -- 5
	('Res Buenavista, Calle 6, #6A', 'Contiguo a Alcaldia', 'SAC01', '02201'), -- 6
	('Res Altavista, Av 7, #7S', 'Contiguo al ISSS', 'SSC03', '01101'), -- 7
	('Col Las Margaritas, Pje 20, #2-4', 'Junto a ANDA', 'AHS01', '02114'),-- 8
	('Urb Las Magnolias, Pol 21, #2-6', 'Casa de esquina', 'LLO01', '01115'),-- 9
	('Caserio Florencia, 3era Calle, #5', 'Casa rosada', 'SON01', '02305');-- 10
    
    INSERT INTO generos (idGenero,generoLiterario) VALUES
	('1','Novela'),
	('2','Poesía'),
	('3','Drama'),
	('4','Ciencia ficción'),
	('5','Fantasía'),
    ('6','aventuras');
    
    INSERT INTO autores (idAutor, nombresAutor, apellidosAutor, nacionalidad) 
    VALUES
    ('1', 'Gabriel García', 'Márquez', 'Colombiano'),
    ('2', 'Julio', 'Cortázar', 'Argentino'),
    ('3', 'Mario', 'Vargas Llosa', 'Peruano'),
    ('4', 'Isabel', 'Allende', 'Chilena'),
    ('5', 'Jorge Luis', 'Borges', 'El Salvador'),
    ('6', ' Josue Israel', 'Tespan Rodriguez', 'El Salvador' );
    
    INSERT INTO cargos (idCargo, nombreCargo) 
    VALUES
    ('1', 'Gerente'), 
    ('2', 'Seguridad'),
    ('3', 'Conserje'),
    ('4', 'Vigilante'),
    ('5', 'Vendedor'), 
    ('6', 'Cajero'), 
    ('7', 'Encargado de Almacén');
    
    INSERT INTO metodosPago (idMetodoPago, nombreMetodoPago) VALUES
    ('1', 'Efectivo'),
    ('2', 'Tarjeta de crédito'),
    ('3', 'Transferencia bancaria');
    
    INSERT INTO clientes (idCliente, nombresClientes, apellidosClientes, duiCliente, telefonoCliente, correoCliente)
    VALUES
	('1', 'Juan', 'Pérez', '04523698-5', '7890-1234', 'juan@example.com'),
	('2', 'María', 'González', '03215897-4', '5678-9012', 'maria@example.com'),
	('3', 'Pedro', 'López', '06789432-1', '1234-5678', 'pedro@example.com'),
    ('4', 'Albert', 'Mendez', '05122373-3', '7563-6732', 'AlbertQexample.com'),
    ('5', 'Marck', 'Spector', '09383467-1', '7345-6754', 'Marck@example.com'),
    ('6', 'Serena', 'Ketchup', '06124534-9', '7456-7823', 'Serena@exmple.com');
    
    INSERT INTO inventarios (idInventario, estante, pasillo, stock) VALUES
    ('1', 'A1', 'Pasillo1', '50'),
	('2', 'B2', 'Pasillo2', '100'),
	('3', 'C3', 'Pasillo3', '75'),
	('4',' D4', 'Pasillo4', '120'),
	('5', 'E5', 'Pasillo5', '90'),
    ('6', 'F6', 'Pasillo6', '25');
    
    INSERT INTO editoriales (idEditorial, nombreEditorial, idDireccion) 
    VALUES
    ('1', 'Editorial A', 1),
    ('2', 'Editorial B', 2),
    ('3', 'Editorial C', 3),
    ('4', 'Editorial D', 4),
    ('5', 'Editorial E', 5),
    ('6', 'Editorial F', 6);
    
    INSERT INTO libros (idLibro, titulo, fechaPublicacion, precioUnitario, idInventario, idEditorial) 
    VALUES
    ('1', 'Cien años de soledad', '1967-05-30', 25.00, 1, 1),
    ('2', 'Rayuela', '1963-06-28', 20.00, 2, 2),
    ('3', 'La ciudad y los perros', '1963-10-19', 22.00, 3, 3),
    ('4', 'La casa de los espíritus', '1982-01-29', 18.00, 4, 4),
    ('5', 'Ficciones', '1944-06-01', 15.00, 5, 5),
    ('6', 'Tensura', '2013-02-20', 12.00, 6, 6);
    
    INSERT INTO sucursales (idSucursal, nombreSucursal, numeroEmpleado, idDireccion)  
	VALUES     
    ('1', 'Librería Central', '1', '1'),     
    ('2', 'Librería El Dorado', '2', '2'),     
    ('3', 'Librería La Torre de los Libros', '3', '3'),     
    ('4', 'Librería del Sol', '4', '4'),     
    ('5', 'Librería El Pergamino Azul', '5', '5'),
    ('6', 'Libreria del Abismo', 6, 6);
    
    insert into empleados (idEmpleado, nombreEmpleado,apellidoEmpleado,fechaDeNacimientoEmpleado,generoEmpleado,duiEmpleado,correoEmpleado,numeroTelefonoEmpleado,numeroSucursalEmpleado,numSeguroSocialEmpleado,numAFP, idDireccion, idCargo, idSucursal) values
    ('1', 'Juan Carlos', 'Rodas Gonzalez','1995-01-01','MASCULINO','04523695-5','juan@hotmail.com','9062-5698','1','123456789','1',1,1,1),
	('2', 'Diego Franciso', 'Sanchez Castro','1990-02-02','MASCULINO','04523695-5','diego@gmail.com','7895-5698','2','987654321','2',2,2,2),
	('3', 'Raul Edgardo', 'Del Valle Garcia', '1980-03-03', 'MASCULINO','03210987-4','raul@outlook.com', '6598-2548', '3','543216789','3',3,3,3),
	('4', 'Mary Carmen', 'Perez de Hernandez','1985-04-04','FEMENINO','06789012-1','may@yahoo.com','7965-2526','4','098764321','4',4,4,4),
    ('5', 'Raul Pedro', 'Reyes Perez', '1998-10-12', 'MASCULINO', '06785645-8', 'Raul@gmail.com','7856-7890','5', '098764321', '5',5,5,5),
    ('6', 'Pedro Raul', 'Ramirez Pereira', '1999-07-12', 'MASCULINO', '09076712-4', 'Pedro@hotmail.com', '7893-7683', '6', '345678912','6',6,6,6);
    
    INSERT INTO pedidos (idPedido, fechaPedido, cantidadTotal, idEditorial, idEmpleado)
	VALUES 
	('1', '2024-04-13', 50, 1, 1),
	('2', '2024-04-14', 75, 2, 2),
	('3', '2024-04-15', 100, 3, 3),
    ('4', '2024-04-16', 125, 4, 4),
    ('5', '2024-04-17', 150, 5, 5),
    ('6', '2024-04-18', 175, 6, 6);
    
    INSERT INTO detallePedidos (idDetallePedido, cantidadLibros, idLibro, idPedido)
	VALUES 
    ('1', 5, 1, 1),
    ('2', 5, 2, 2),
    ('3', 6, 3, 3),
    ('4', 6, 4, 4),
    ('5', 7, 5, 5),
    ('6', 7, 6, 6);
    
    INSERT INTO ventas(idVenta, montoTotal, fechaVenta, idEmpleado,idCliente,idMetodoPago) 
    VALUES
    ('1', 150.00, '2024-04-13', 1, 1, 1),          
    ('2', 200.00, '2024-04-14', 2, 2, 2),          
    ('3', 300.00, '2024-04-15', 3, 3, 3),
    ('4', 250.00, '2024-04-16', 4, 4, 3),
    ('5', 550.00, '2024-04-17', 5, 5, 2),
    ('6', 780.00, '2024-04-18', 6, 6, 1);
    
    INSERT INTO detalleVentas (idDetalleVenta, idLibro, idVenta)
    values
    ('1', 1, 1),
    ('2', 2, 2),
    ('3', 3, 3),
    ('4', 4, 4),
    ('5', 5, 5),
    ('6', 6, 6);
    
    INSERT INTO facturasVentas (idFacturaVenta, fechaFacturaVenta, totalPagarVenta, ivaFacturaVenta, creditoFiscalFacturaVenta, idDetalleVenta)
	VALUES 
	('1', '2024-04-14', 150.00, 25, 'ABC123', 1),     
	('2', '2024-04-15', 250.00, 30, 'ABC234', 2),     
	('3', '2024-04-16', 350.00, 35, 'ABC345', 3),     
	('4', '2024-04-17', 450.00, 45, 'ABC456', 4),     
	('5', '2024-04-18', 550.00, 55, 'ABC567', 5),     
	('6', '2024-04-19', 650.00, 65, 'ABC678', 6);
    
    INSERT INTO facturasCompras (idFacturaCompra, fechaFacturaCompra, totalPagarCompra, ivaFacturaCompra, creditoFiscalFacturaCompra, idDetallePedido)
	VALUES 
	('1', '2024-04-13', 500.00, 50, 'CF001', 1),
	('2', '2024-04-14', 700.00, 70, 'CF002', 2),
	('3', '2024-04-15', 900.00, 90, 'CF003', 3),
    ('4', '2024-04-16', 950.00, 50, 'CF001', 4),
    ('5', '2024-04-17', 550.00, 50, 'CF001', 5),
    ('6', '2024-04-18', 350.00, 50, 'CF001', 6);
    
    INSERT INTO detallesGenerosLibros (idGenero, idLibro) VALUES 
    (1,1),
    (2,2),
    (3,3),
    (4,4),
    (5,5),
    (6,6);
    
    INSERT INTO detallesAutoresLibros(idAutor, idLibro) VALUES
    (1,1),
    (2,2),
    (3,3),
    (4,4),
    (5,5),
    (6,6);