CREATE TABLE IF NOT EXISTS `bm_mafias` (
    `id` int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL UNIQUE KEY,
    `metadata` longtext NOT NULL DEFAULT '[]'
);

CREATE TABLE IF NOT EXISTS `mafia_stock` (
    `smg` int(11) NOT NULL DEFAULT '0',
    `ak` int(11) NOT NULL DEFAULT '0',
    `smg_assault` int(11) NOT NULL DEFAULT '0',
    `revolver` int(11) NOT NULL DEFAULT '0',
    `carabina` int(11) NOT NULL DEFAULT '0',
    `microsmg` int(11) NOT NULL DEFAULT '0',
    `bproof` int(11) NOT NULL DEFAULT '0'
);