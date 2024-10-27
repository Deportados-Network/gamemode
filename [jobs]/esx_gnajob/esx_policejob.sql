INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_gna', 'gna', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_gna', 'gna', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_gna', 'gna', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('gna', 'Gendarmeria')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('gna',0,'Aspirante','Aspirante',20000,'{}','{}'),
	('gna',1,'Experimentado','Experimentado',23000,'{}','{}'),
	('gna',2,'Avanzado','Avanzado',25000,'{}','{}'),
	('gna',3,'Suboficial','Suboficial',28000,'{}','{}'),
	('gna',4,'oficial','oficial',30000,'{}','{}'),
	('gna',0,'Vigilante','Vigilante',35000,'{}','{}'),
	('gna',1,'Auxiliar','Auxiliar',36000,'{}','{}'),
	('gna',2,'Auxiliar1','Auxiliar avanzado',38000,'{}','{}'),
	('gna',3,'Subsheriff','Subsheriff',41000,'{}','{}'),
	('gna',4,'sheriff','sheriff',43000,'{}','{}'),
	('gna',0,'Subcoronel','Sub coronel',45000,'{}','{}'),
	('gna',1,'Coronel','Coronel',48000,'{}','{}'),
	('gna',2,'Instructor','Instructor',50000,'{}','{}'),
	('gna',3,'Subjefe','Subjefe',53000,'{}','{}'),
	('gna',4,'Jefe','Jefe',55000,'{}','{}')
;
CREATE TABLE `fine_types` (
	`id` int NOT NULL AUTO_INCREMENT,
	`label` varchar(255) DEFAULT NULL,
	`amount` int DEFAULT NULL,
	`category` int DEFAULT NULL,

	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO `fine_types` (label, amount, category) VALUES
('Uso abusivo del claxon', 30, 0),
('Cruzar una línea continua', 40, 0),
('Circulación en sentido contrario', 250, 0),
('Giro prohibido', 250, 0),
('Circulación fuera de la carretera', 170, 0),
('No respetar las distancias de seguridad', 30, 0),
('Detención peligrosa/prohibida', 150, 0),
('Estacionamiento molesto/prohibido', 70, 0),
('No respetar la prioridad a la derecha', 70, 0),
('No respetar a un vehículo prioritario', 90, 0),
('No respetar una señal de alto', 105, 0),
('No respetar un semáforo en rojo', 130, 0),
('Adelantamiento peligroso', 100, 0),
('Vehículo en mal estado', 100, 0),
('Conducción sin licencia', 1500, 0),
('Fuga del lugar del accidente', 800, 0),
('Exceso de velocidad < 5 km/h', 90, 0),
('Exceso de velocidad 5-15 km/h', 120, 0),
('Exceso de velocidad 15-30 km/h', 180, 0),
('Exceso de velocidad > 30 km/h', 300, 0),
('Obstrucción del tráfico', 110, 1),
('Daño a la vía pública', 90, 1),
('Alteración del orden público', 90, 1),
('Obstrucción a la operación de la GNA', 130, 1),
('Insulto hacia/entre civiles', 75, 1),
('Ultraje a un agente de la GNA', 110, 1),
('Amenaza verbal o intimidación hacia un civil', 90, 1),
('Amenaza verbal o intimidación hacia un policía', 150, 1),
('Manifestación ilegal', 250, 1),
('Intento de corrupción', 1500, 1),
('Arma blanca exhibida en la ciudad', 120, 2),
('Arma letal exhibida en la ciudad', 300, 2),
('Porte de arma no autorizada (falta de licencia)', 600, 2),
('Porte de arma ilegal', 700, 2),
('Atrapado en el acto de ganzúa', 300, 2),
('Robo de automóvil', 1800, 2),
('Venta de drogas', 1500, 2),
('Fabricación de drogas', 1500, 2),
('Posesión de drogas', 650, 2),
('Toma de rehenes civiles', 1500, 2),
('Toma de rehenes a un agente del estado', 2000, 2),
('Asalto a particulares', 650, 2),
('Asalto a una tienda', 650, 2),
('Asalto a un banco', 1500, 2),
('Disparo a civiles', 2000, 3),
('Disparo a un agente del estado', 2500, 3),
('Intento de asesinato de un civil', 3000, 3),
('Intento de asesinato de un agente del estado', 5000, 3),
('Asesinato de un civil', 10000, 3),
('Asesinato de un agente del estado', 30000, 3),
('Asesinato involuntario', 1800, 3),
('Estafa a la empresa', 2000, 2)
;
