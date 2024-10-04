

CREATE TABLE IF NOT EXISTS Partido (
  nro INT NOT NULL AUTO_INCREMENT,
  cod_local VARCHAR(3),
  gol_local INT,
  cod_visitante VARCHAR(3),
  gol_visitante INT,
  PRIMARY KEY (nro)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE IF NOT EXISTS EquipoPais (
  id_equipo VARCHAR(3) PRIMARY KEY,
  nombre_pais VARCHAR(50)
);


TRUNCATE TABLE Partido;
TRUNCATE TABLE EquipoPais;


INSERT INTO Partido (cod_local, gol_local, cod_visitante, gol_visitante)
VALUES 

('QA', 0, 'EC', 2), 
('SN', 0, 'NL', 2), 
('EN', 6, 'IR', 2), 
('AR', 1, 'SA', 2), 
('FR', 4, 'AU', 1), 
('BR', 2, 'SR', 0), 
('DE', 1, 'JP', 2), 
('ES', 7, 'CR', 0), 

('QA', 1, 'SN', 3), 
('NL', 1, 'EC', 1), 
('EN', 0, 'US', 0), 
('IR', 0, 'AR', 1), 
('SA', 0, 'FR', 2), 
('AU', 1, 'BR', 2), 
('JP', 0, 'DE', 1),
('CR', 1, 'ES', 1), 

('AR', 2, 'MX', 0), 
('PL', 2, 'SA', 0), 
('FR', 1, 'DE', 2), 
('AU', 1, 'TN', 0), 
('CR', 1, 'JP', 0), 
('US', 1, 'IR', 0), 
('EC', 1, 'SN', 2), 
('NL', 2, 'QA', 0), 


('AR', 2, 'AU', 1), 
('FR', 3, 'PL', 1), 
('EN', 3, 'SN', 0), 
('NL', 3, 'US', 1), 

('AR', 2, 'NL', 2), 
('FR', 2, 'EN', 1), 
('AR', 3, 'FR', 3), 
('MAR', 0, 'CRO', 2); 


INSERT IGNORE INTO EquipoPais (id_equipo, nombre_pais)
VALUES 
('QA', 'Qatar'),
('EC', 'Ecuador'),
('SN', 'Senegal'),
('NL', 'Países Bajos'),
('EN', 'Inglaterra'),
('IR', 'Irán'),
('AR', 'Argentina'),
('SA', 'Arabia Saudita'),
('FR', 'Francia'),
('AU', 'Australia'),
('BR', 'Brasil'),
('SR', 'Serbia'),
('DE', 'Alemania'),
('JP', 'Japón'),
('ES', 'España'),
('CR', 'Costa Rica'),
('US', 'Estados Unidos'),
('MX', 'México'),
('PL', 'Polonia'),
('TN', 'Túnez'),
('CM', 'Camerún'),
('GH', 'Ghana'),
('UY', 'Uruguay'),
('PT', 'Portugal'),
('MAR', 'Marruecos'),
('HR', 'Croacia');


SELECT ep.nombre_pais, SUM(tot.goles) AS goltot
FROM (
  SELECT cod_local AS codigo_pais, gol_local AS goles FROM Partido
  UNION ALL
  SELECT cod_visitante AS codigo_pais, gol_visitante AS goles FROM Partido
) AS tot
JOIN EquipoPais ep ON tot.codigo_pais = ep.id_equipo
GROUP BY ep.nombre_pais
ORDER BY goltot DESC;


SELECT ep.nombre_pais, SUM(tot.goles) AS goltot
FROM (
  SELECT cod_local AS codigo_pais, gol_local AS goles FROM Partido
  UNION ALL
  SELECT cod_visitante AS codigo_pais, gol_visitante AS goles FROM Partido
) AS tot
JOIN EquipoPais ep ON tot.codigo_pais = ep.id_equipo
GROUP BY ep.nombre_pais
ORDER BY goltot DESC
LIMIT 3;


SELECT ep.nombre_pais, SUM(tot.goles) AS goltot
FROM (
  SELECT cod_local AS codigo_pais, gol_local AS goles FROM Partido
  UNION ALL
  SELECT cod_visitante AS codigo_pais, gol_visitante AS goles FROM Partido
) AS tot
JOIN EquipoPais ep ON tot.codigo_pais = ep.id_equipo
GROUP BY ep.nombre_pais
ORDER BY goltot DESC;


SELECT ep.nombre_pais, 
       COUNT(CASE WHEN cod_local = ep.id_equipo THEN 1 END) +
       COUNT(CASE WHEN cod_visitante = ep.id_equipo THEN 1 END) AS partidos_jugados,
       SUM(CASE WHEN cod_local = ep.id_equipo THEN gol_local ELSE 0 END) +
       SUM(CASE WHEN cod_visitante = ep.id_equipo THEN gol_visitante ELSE 0 END) AS goles_totales,
       AVG(CASE WHEN cod_local = ep.id_equipo THEN gol_local ELSE 0 END +
           CASE WHEN cod_visitante = ep.id_equipo THEN gol_visitante ELSE 0 END) AS promedio_goles
FROM Partido
JOIN EquipoPais ep ON cod_local = ep.id_equipo OR cod_visitante = ep.id_equipo
GROUP BY ep.id_equipo
ORDER BY goles_totales DESC;