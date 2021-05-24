\qecho ---Mostramos el nombre de los socios con suscripcion anual---
SELECT Nombre FROM Socio_Suscripcion WHERE Tipo='Anual';
\qecho ---Mostramos el nombre de los monitores que imparten Yoga, sabiendo que hay 3 clases diferentes segun el nivel---
SELECT Empleado_AML.Nombre FROM  Empleado_AML WHERE DNI_E IN (SELECT Imparte.DNI_E FROM Imparte FULL JOIN Actividad ON Imparte.Actividad_ID=Actividad.ID WHERE Actividad.Nombre LIKE '%Yoga%');
\qecho ---Mostramos el numero de asistentes de la clase con mas asistencias del dia 12/05/2021---
SELECT MAX(cuenta) FROM (SELECT Actividad_ID, COUNT(DNI_Socio) Cuenta FROM Asiste WHERE Fecha='01/05/2021' GROUP BY Actividad_ID) AS MAXIMO;
\qecho ---Mostramos el nombre de todas las clases que se dan el jueves---
SELECT Nombre FROM Actividad WHERE Días LIKE '%J%';
\qecho ---Mostramos los meses que coordina el monitor Adela Ante---
SELECT Mes FROM Coordina INNER JOIN Empleado_AML ON Coordina.DNI_E=Empleado_AML.DNI_E WHERE Empleado_AML.Nombre='Adela Ante' GROUP BY Mes;
\qecho ---Mostramos la fecha, actividad y asistentes de las actividades donde se completo el aforo---
 CREATE VIEW Clases_Completas AS (SELECT Actividad.Nombre, SUBCONSULTA.Actividad_ID, SUBCONSULTA.cuenta, SUBCONSULTA.Fecha FROM Actividad Natural Join (SELECT Fecha, Actividad_ID, COUNT(DNI_Socio) Cuenta FROM Asiste GROUP BY Actividad_ID, Fecha) AS SUBCONSULTA WHERE Actividad.ID = SUBCONSULTA.Actividad_ID AND Actividad.Aforo = SUBCONSULTA.Cuenta);
 SELECT Fecha, Clases_Completas.nombre, Socio_Suscripcion.nombre FROM ASISTE NATURAL JOIN Clases_Completas, SOCIO_SUSCRIPCION WHERE ASISTE.DNI_SOCIO  = SOCIO_SUSCRIPCION.DNI_SOCIO;
 DROP VIEW Clases_Completas;