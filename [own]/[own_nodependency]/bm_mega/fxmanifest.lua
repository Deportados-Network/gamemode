fx_version 'cerulean'
game 'gta5'

client_scripts {
    '@PolyZone/client.lua',
    'client/cl_main.lua',
    'client/modules/*.lua'
}

server_scripts {'@oxmysql/lib/MySQL.lua', 'config.lua', 'server/sv_main.lua'}

lua54 'yes'