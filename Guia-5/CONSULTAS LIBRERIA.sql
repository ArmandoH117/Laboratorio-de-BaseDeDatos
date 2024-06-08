-- Mostrar una lista de todos los libros que se encuentran en el stock, así como sus
-- respectivos detalles de género, autor, y precio de venta.
SELECT 
    l.titulo AS TituloLibro,
    l.fechaPublicacion AS FechaPublicacion,
    l.precioUnitario AS PrecioUnitario,
    g.generoLiterario AS GeneroLiterario,
    CONCAT(a.nombresAutor, ' ', a.apellidosAutor) AS Autor
FROM 
    libros l
    INNER JOIN generos g ON l.idGenero = g.idGenero
    INNER JOIN autores a ON l.idAutor = a.idAutor;

-- Mostrar una lista de las ventas realizadas, con los detalles del cliente que compró,
-- el vendedor, y el nombre del libro que adquirió.

SELECT 
    v.idVenta,
    c.nombresClientes AS Cliente,
    CONCAT(e.nombreEmpleado, ' ', e.apellidoEmpleado) AS Vendedor,
    l.titulo AS Libro_Adquirido
FROM 
    ventas v
    INNER JOIN clientes c ON v.idCliente = c.idCliente
    INNER JOIN empleados e ON v.idEmpleado = e.idEmpleado
    INNER JOIN libros l ON v.idLibro = l.idLibro;
