shared_script '@WaveShield/resource/waveshield.js' --this line was automatically written by WaveShield

shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version 'adamant'

game 'gta5'

author 'Raz'

description 'Actividades'

client_scripts {
    'config.lu*',
    'client/main.lu*',
    'client/electricista.lu*',
    'client/ganadero.lu*',
    'client/puerto.lu*',
    'client/farm.lu*',

}

server_scripts {
    'server/server.lua',
    'config.lua'
}