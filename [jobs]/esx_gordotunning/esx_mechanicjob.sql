USE `depo`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_gordotunning', 'GordoTunning', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_gordotunning', 'GordoTunning', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_gordotunning', 'GordoTunning', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('gordotunning', 'GordoTunning')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('gordotunning',0,'recrue','Recluta',12,'{}','{}'),
	('gordotunning',1,'novice','Novato',24,'{}','{}'),
	('gordotunning',2,'experimente','Experimentado',36,'{}','{}'),
	('gordotunning',3,'chief',"Instructor",48,'{}','{}'),
	('gordotunning',4,'boss','Jefe',0,'{}','{}')
;