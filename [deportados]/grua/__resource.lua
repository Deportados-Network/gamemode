shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version 'cerulean'

games { 'rdr3', 'gta5' }

server_script {
    'config.lua',
    'server/server.lua'
}
client_scripts {
    'config.lua',
    'client/client.lua',
    'client/entityiter.lua'
}
shared_script '@es_extended/imports.lua'