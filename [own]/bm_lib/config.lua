Config = {
    ['user'] = {
        label = "Usuario",
        badge = "user",
        level = 0
    },

    -- @ Low-Level STAFF
    ['learner'] = {
        label = "Soporte",
        color = "1",
        badge = "learner",
        level = 1
    },
    ['junior'] = {
        label = "Soporte Experimentado",
        color = "2",
        badge = "junior",
        level = 2
    },
    ['senior'] = {
        label = "Soporte Maestro",
        color = "2",
        badge = "senior",
        level = 3
    },
    ['asistent'] = {
        label = "Moderador",
        color = "2",
        badge = "asistent",
        level = 4
    },

    -- @ Medium-Level STAFF
    ['trainer'] = {
        label = "Moderador Experimentado",
        color = "2",
        badge = "trainer",
        level = 6
    },
    ['specialist'] = {
        label = "Moderador Maestro",
        color = "2",
        badge = "specialist",
        level = 7
    },
    ['analyst'] = {
        label = "Administrador",
        color = "2",
        badge = "analyst",
        level = 8
    },
    ['supervisor'] = {
        label = "Administrador Experimentado",
        color = "2",
        badge = "supervisor",
        level = 9
    },

    -- @ Advanced-Level STAFF
    ['master'] = {
        label = "Administrador Maestro",
        color = "2",
        badge = "master",
        level = 10
    },
    ['developer'] = {
        label = "Developer",
        color = "2",
        badge = "developer",
        level = 11
    },

    -- @ Supreme-Level STAFF
    ['coo'] = {
        label = "COO",
        color = "2",
        badge = "coo",
        level = 12
    },
    ['root'] = {
        label = "CEO",
        color = "9",
        badge = "ceo",
        level = 99
    },

}

function getConfig()
    return Config
end
exports('getConfig', getConfig)