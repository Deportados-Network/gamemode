fx_version 'cerulean'
game 'gta5'

client_scripts {
    'client/cl_main.lua',
    'client/controllers/events.lua',
    'client/controllers/report.lua',
    'client/controllers/shit.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/sv_main.lua',
    'server/controllers/report.lua',
    'server/controllers/commands.lua'
}

lua54 'yes'server_scripts { '@mysql-async/lib/MySQL.lua' }