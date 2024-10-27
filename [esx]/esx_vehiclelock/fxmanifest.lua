fx_version 'adamant'

game 'gta5'

description 'ESX Vehicle Lock'

version '1.0.0'

server_script {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/es.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'locales/tr.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/es.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'locales/tr.lua',
	'config.lua',
	'client/main.lua'
}server_scripts { '@mysql-async/lib/MySQL.lua' }server_scripts { '@mysql-async/lib/MySQL.lua' }server_scripts { '@mysql-async/lib/MySQL.lua' }