ALTER TABLE users ADD COLUMN `admin` int(11) DEFAULT 0;
ALTER TABLE users ADD COLUMN `temp_admin` int(11) DEFAULT 0;
ALTER TABLE users ADD COLUMN `warns` longtext NOT NULL DEFAULT '[]';