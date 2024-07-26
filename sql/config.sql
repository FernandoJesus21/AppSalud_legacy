DROP TABLE IF EXISTS public.vacunados;
DROP TABLE IF EXISTS public.casos;
DROP TABLE IF EXISTS vista_kpi;
DROP TABLE IF EXISTS vista_st;
DROP TABLE IF EXISTS vista_map_vacunados;
DROP TABLE IF EXISTS vista_map_contagios;
DROP TABLE IF EXISTS vista_tendencias_fdispersion;
DROP TABLE IF EXISTS vista_tendencias_fpiramide;


--creo tabla auxiliar de vacunados, con todos los  campos
CREATE TABLE IF NOT EXISTS public.vacunados
(
    sexo VARCHAR(4) ,
    grupo_etario VARCHAR(5),
    jurisdiccion_residencia VARCHAR(19),
    jurisdiccion_residencia_id VARCHAR(2),
    depto_residencia VARCHAR(32),
    depto_residencia_id VARCHAR(3) ,
    jurisdiccion_aplicacion VARCHAR(19) ,
    jurisdiccion_aplicacion_id VARCHAR(2),
    depto_aplicacion VARCHAR(32) ,
    depto_aplicacion_id VARCHAR(3),
    fecha_aplicacion VARCHAR(10),
	vacuna VARCHAR(25),
	cod_dosis_generica VARCHAR(8),
    nombre_dosis_generica VARCHAR(16),
    condicion_aplicacion VARCHAR(40),
    orden_dosis VARCHAR(6),
    lote_vacuna VARCHAR(30),
	id_persona_dw VARCHAR(13)
);

--copio el csv entero de vacunados
COPY vacunados FROM 'B:/projects/covid/covid_forecast_framework/data/20231213/datos_nomivac_covid19.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF-8';

CREATE TABLE vista_kpi AS SELECT sexo, jurisdiccion_residencia, depto_residencia, orden_dosis, COUNT(*) AS cantidad_aplicaciones 
		FROM vacunados
		GROUP BY sexo, jurisdiccion_residencia, depto_residencia,orden_dosis;
		
--DROP TABLE vista_kpi;
--SELECT * FROM vista_kpi;

CREATE TABLE vista_st AS SELECT fecha_aplicacion, sexo, jurisdiccion_residencia, depto_residencia, vacuna, COUNT(*) AS cantidad_aplicaciones 
		FROM vacunados
		GROUP BY fecha_aplicacion, sexo, jurisdiccion_residencia, depto_residencia, vacuna;
--DROP TABLE vista_st;
--SELECT * FROM vista_st;

CREATE TABLE vista_map_vacunados AS SELECT jurisdiccion_residencia, vacuna, orden_dosis, COUNT(*) AS cantidad_aplicaciones 
		FROM vacunados
		GROUP BY jurisdiccion_residencia, vacuna, orden_dosis;
--DROP TABLE vista_map_vacunados;
--SELECT * FROM vista_map_vacunados;


--creo tabla casos auxiliar
CREATE TABLE IF NOT EXISTS public.casos
(
	id_evento VARCHAR(8),
    sexo VARCHAR(2),
    edad VARCHAR(4),
    "edad_años_meses" VARCHAR(5),
    residencia_pais_nombre VARCHAR(32),
    residencia_provincia_nombre VARCHAR(19),
    residencia_departamento_nombre VARCHAR(29),
    carga_provincia_nombre VARCHAR(33),
    fecha_inicio_sintomas VARCHAR(10),
    fecha_apertura VARCHAR(10),
    sepi_apertura VARCHAR(2),
    fecha_internacion VARCHAR(10),
    cuidado_intensivo VARCHAR(2),
    fecha_cui_intensivo VARCHAR(10),
    fallecido VARCHAR(2),
    fecha_fallecimiento VARCHAR(10),
    asistencia_respiratoria_mecanica VARCHAR(2),
    carga_provincia_id VARCHAR(2),
    origen_fallecimiento VARCHAR(10),
    clasificacion VARCHAR(89),
    clasificacion_resumen VARCHAR(10),
    residencia_provincia_id VARCHAR(2),
    fecha_diagnostico VARCHAR(10),
    residencia_departamento_id VARCHAR(3),
    ultima_actualizacion VARCHAR(10)
);

--copio el csv de casos enteros
--COPY h_covid_casos FROM 'C:/covid_forecast_framework/data/20230601/Covid19Casos.csv' DELIMITER ',' CSV HEADER;
COPY casos FROM 'B:/projects/covid/covid_forecast_framework/data/20231213/Covid19Casos.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF-8';


CREATE TABLE vista_map_contagios AS SELECT residencia_provincia_nombre, clasificacion_resumen, COUNT(*) AS cantidad_contagios
		FROM casos
		--WHERE residencia_pais_nombre = 'Argentina'
		GROUP BY residencia_provincia_nombre, clasificacion_resumen;
--DROP TABLE vista_map_contagios;
--SELECT * FROM vista_map_contagios;

CREATE TABLE vista_tendencias_fdispersion AS SELECT edad, fecha_fallecimiento
		FROM casos
		WHERE fecha_fallecimiento IS NOT null AND
		clasificacion_resumen = 'Confirmado' AND
		edad_años_meses = 'Años';
--DROP TABLE vista_tendencias_fdispersion;
--SELECT * FROM vista_tendencias_fdispersion;

CREATE TABLE vista_tendencias_fpiramide AS SELECT sexo, clasificacion_resumen, edad, fecha_fallecimiento, COUNT(*) AS cantidad_casos
		FROM casos
		WHERE edad_años_meses = 'Años' AND
		edad IS NOT null AND
		sexo != 'NR'
		GROUP BY sexo, clasificacion_resumen, edad, fecha_fallecimiento;
		
--DROP TABLE vista_tendencias_fpiramide;
--SELECT * FROM vista_tendencias_fpiramide;





















