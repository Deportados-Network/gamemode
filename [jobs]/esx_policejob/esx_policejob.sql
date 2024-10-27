INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_police', 'Police', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_police', 'Police', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_police', 'Police', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('police', 'LSPD')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('police',0,'recruit','Recrue',20,'{}','{}'),
	('police',1,'officer','Officier',40,'{}','{}'),
	('police',2,'sergeant','Sergent',60,'{}','{}'),
	('police',3,'lieutenant','Lieutenant',85,'{}','{}'),
	('police',4,'boss','Commandant',100,'{}','{}')
;

CREATE TABLE `fine_types` (
	`id` int NOT NULL AUTO_INCREMENT,
	`label` varchar(255) DEFAULT NULL,
	`amount` int DEFAULT NULL,
	`category` int DEFAULT NULL,

	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO `fine_types` (label, amount, category) VALUES
('Uso abusivo del claxon', 3000, 0),
('Cruzar una línea continua', 4000, 0),
('Circulación en sentido contrario', 25000, 0),
('Hacer un giro en U no autorizado', 25000, 0),
('Circulación fuera de la carretera', 17000, 0),
('No respetar las distancias de seguridad', 3000, 0),
('Parada peligrosa/prohibida', 15000, 0),
('Estacionamiento obstruyente/prohibido', 7000, 0),
('No respetar la prioridad a la derecha', 7000, 0),
('No respetar a un vehículo prioritario', 9000, 0),
('No respetar una señal de stop', 10500, 0),
('No respetar un semáforo rojo', 13000, 0),
('Adelantamiento peligroso', 10000, 0),
('Vehículo en mal estado', 10000, 0),
('Conducir sin licencia', 150000, 0),
('Fuga de la escena del crimen', 80000, 0),
('Exceso de velocidad < 5 km/h', 9000, 0),
('Exceso de velocidad 5-15 km/h', 12000, 0),
('Exceso de velocidad 15-30 km/h', 18000, 0),
('Exceso de velocidad > 30 km/h', 30000, 0),


('Obstrucción del tráfico', 11000, 1),
('Daño a la vía pública', 9000, 1),
('Alteración del orden público', 9000, 1),
('Obstrucción a operación policial', 13000, 1),
('Insulto entre civiles', 7500, 1),
('Uso indebido contra un agente de policía', 11000, 1),
('Amenaza verbal o intimidación a civiles', 9000, 1),
('Amenaza verbal o intimidación a policías', 15000, 1),
('Manifestación ilegal', 25000, 1),
('Intento de soborno', 150000, 1),


('Arma blanca exhibida en la ciudad', 12000, 2),
('Arma letal exhibida en la ciudad', 30000, 2),
('Portar arma no autorizada (sin licencia)', 60000, 2),
('Portar arma ilegal', 70000, 2),
('Atrapado in fraganti forzando cerraduras', 30000, 2),
('Robo de automóvil', 90000, 2),   
('Venta de drogas', 75000, 2),    
('Fabricación de drogas', 75000, 2), 
('Posesión de drogas', 32500, 2),   
('Toma de rehenes civiles', 75000, 2),
('Toma de rehenes a agentes del estado', 100000, 2),
('Asalto a un individuo', 32500, 2),   
('Asalto a una tienda', 32500, 2),   
('Asalto a un banco', 75000, 2),   
('Disparo a civiles', 100000, 3),


('Disparo a agentes del estado', 125000, 3),
('Intento de asesinato a civiles', 150000, 3),
('Intento de asesinato a agentes del estado', 250000, 3),
('Asesinato a civiles', 500000, 3),
('Asesinato a agentes del estado', 1500000, 3),
('Homicidio involuntario', 90000, 3),  
('Estafa a la empresa', 100000, 2)
;
