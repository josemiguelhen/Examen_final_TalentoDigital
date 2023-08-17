/* Actividad 1: Consultas a la base de datos */

/*Consulta 1: 
Se solicita mostrar el nombre de cada paciente  y el nombre del doctor con el que tienen una cita asignada */

use gestionClinica;

SELECT P.Nombre AS NombrePaciente, D.Nombre AS NombreDoctor
FROM Citas C
JOIN Pacientes P ON C.ID = P.ID
JOIN Doctores D ON C.ID = D.ID;

/* Consulta 2:
Se solicita una lista del Nombre y la Especialidad de todos los doctores que atendieron al paciente "Juan Pérez" */

SELECT D.Nombre AS Doctor, E.Nombre AS Especialidad
FROM Citas C
JOIN Pacientes P ON C.Paciente_ID = P.ID
JOIN Doctores D ON C.Doctor_ID = D.ID
JOIN Especialidades E ON D.Especialidad_ID = E.ID
WHERE P.Nombre = 'Juan Pérez';

/* Consulta 3:
Se solicita una lista con el monto que factura cada doctor, ordenados alfabéticamente de forma ascendente, agrupados por el nombre del doctor*/

SELECT D.Nombre AS Doctor, SUM(F.Monto) AS MontoFactura
FROM Doctores D
JOIN Citas C ON C.Doctor_ID = D.ID
JOIN Facturas F ON C.Factura_ID = F.ID
group by D.Nombre
ORDER BY D.Nombre DESC;

/* Consulta 4:
Se solicita una lista que muestre por paciente el diagnóstico y tratamiento que recibió en su última cita. Ordenados de forma ascendiente por el id del paciente */

SELECT P.ID AS IDpaciente, P.Nombre AS nombrePaciente, HC.Diagnostico, HC.Tratamiento
FROM Pacientes P 
JOIN Historia_Clinica HC ON P.ID = HC.Paciente_ID
WHERE HC.Fecha_cita = (SELECT MAX(Fecha_cita) FROM Historia_Clinica WHERE Paciente_ID = P.ID)
GROUP BY P.ID, HC.Diagnostico, HC.Tratamiento
ORDER BY P.ID ASC;

/* Consulta 5:
Se solicita una lista con la cantidad de pacientes que ha atendido cada doctor */

SELECT D.Nombre AS NombreDoctor, count(distinct C.Paciente_ID) AS cantidadPacientes
FROM Doctores D
JOIN Citas C ON C.Doctor_ID = D.ID
GROUP BY D.Nombre;



