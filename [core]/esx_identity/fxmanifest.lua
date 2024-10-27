server_script "4FOQ.lua"
client_script "4FOQ.lua"
fx_version 'adamant'

game 'gta5'

description 'ESX Identity'

version 'legacy'

shared_script '@es_extended/imports.lua'

server_scripts {
	'@es_extended/locale.lua',
	'@mysql-async/lib/MySQL.lua',
	'locales/en.lua',
	'locales/es.lua',
	'locales/cs.lua',
	'locales/pl.lua',
	'locales/fi.lua',	
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/es.lua',
	'locales/cs.lua',
	'locales/pl.lua',
	'locales/fi.lua',	
	'config.lua',
	'client/main.lua'
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/js/script.js',
	'html/css/style.css',
	'html/img/*.png', 
	'html/img/*.jpg'
}

dependency 'es_extended'
