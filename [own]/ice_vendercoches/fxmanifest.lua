fx_version 'cerulean'

game "gta5"

server_script{ 
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

client_script 'client.lua'














