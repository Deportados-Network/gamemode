fx_version 'cerulean'
game 'gta5'
author 'byK3#7147'
description 'Simple system to set Ped to player & save it'
version '1.0.0'

shared_script '@es_extended/imports.lua'

client_scripts {
    'config.lua',
    'client.lua',
}

server_scripts {
    'config.lua',  -- Asegúrate de que config.lua cargue antes que server.lua
    'server.lua',
}

file 'save.json'
