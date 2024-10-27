fx_version 'cerulean'
game 'gta5'

ui_page 'client/ui/index.html'

client_scripts {
    'client/cl_main.lua'
}

server_script 'server/sv_main.lua'

files {
    'client/ui/index.html',
    'client/ui/style.css',
    'client/ui/script.js'
}

lua54 'yes'