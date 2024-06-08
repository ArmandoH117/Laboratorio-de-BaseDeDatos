-- DDL BASE DE DATOS LIBRERIA --
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
    idMetodoPago INT NOT NULL,
    idLibro INT NOT NULL
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
	idEditorial INT NOT NULL,
    idGenero INT NOT NULL,
    idAutor INT NOT NULL
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
-- TABLA ROLES --
CREATE TABLE roles(
	idRol INT PRIMARY KEY AUTO_INCREMENT,
    rol VARCHAR(50) NOT NULL
);
CREATE TABLE opciones (
  idOpcion INT PRIMARY KEY AUTO_INCREMENT,
  opcion VARCHAR(50) NOT NULL
);
CREATE TABLE asignacionRolesOpciones(
	idAsignacion INT PRIMARY KEY AUTO_INCREMENT,
    idRol INT NOT NULL,
    idOpcion INT NOT NULL
);
CREATE TABLE usuarios (
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    usuario VARCHAR(50) NOT NULL,
    contrasenia VARCHAR(50) NOT NULL,
    idRol INT NOT NULL,
    idEmpleado INT NOT NULL
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
alter table ventas add foreign key (idLibro) references libros(idLibro);
-- llave foranea editoreales 
alter table editoriales add foreign key (idDireccion) references direcciones(idDireccion);
-- llave foranea libros
alter table libros add foreign key (idInventario) references inventarios(idInventario);
alter table libros add foreign key (idEditorial) references editoriales(idEditorial);
alter table libros add foreign key (idGenero) references generos(idGenero);
alter table libros add foreign key (idAutor) references autores(idAutor);
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
-- Llaves Roles --
alter table asignacionRolesOpciones add foreign key (idRol) references roles(idRol);
alter table asignacionRolesOpciones add foreign key (idOpcion) references opciones(idOpcion);
alter table usuarios add foreign key (idRol) references roles(idRol);
alter table usuarios add foreign key (idEmpleado) references empleados(idEmpleado);