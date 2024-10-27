Config = {}

Config.Translation = function(source, name, reason)
    return '~b~[~y~'..source..'~b~] ~b~'..name..'~s~ SE HA DESCONECTADO DEL SERVIDOR.\n~o~RAZON~s~: ~r~'..reason;
end

Config.Reasons = {
    ['timed out'] = 'Tiempo de espera agotado.',
    ['crash'] = 'Crasheó.',
    ['Exiting'] = 'Quiteó.',
    ['Disconnected.'] = 'Desconectado.',
}
