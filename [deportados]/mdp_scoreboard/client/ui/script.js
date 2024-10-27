var app = new Vue({
    el: '#app',
    data: {
        show: true,
        weapon: "Pistola - 500 balas",
        playerJob: "Mecánico - Empleado",
        playerMoney: [0, 0, 0, 0],
        weapon: null,
        vehicleSpeed: 0,
        fuel: 0,
        hunger: 0,
        thirst: 0,
        playerId: 0,
        hour: undefined,
        date: undefined,
        cops: 0,
        medicos: 0,
        gendarmes: 0,
        players: 0,
        serverStats: false,
        maxPlayers: 0,
        mhz: undefined
    }, 
    mounted() {
        window.addEventListener('message', (event) => {
            const data = event.data;

            if (data.action) {
                switch (data.action) {
                    case 'show':
                        app.show = data.show;

                    case 'serverStats':
                        app.serverStats = data.show;
                        app.cops = data.cops;
                        app.medicos = data.medicos;
                        app.gendarmes = data.gendarmes;
                        app.players = data.players;
                        app.maxPlayers = data.maxPlayers;

                    case 'update':
                        if (data.job)
                            app.playerJob = data.job;

                        if (data.hour)
                            app.hour = data.hour;

                        if (data.date)
                            app.date = data.date;

                        if (data.playerId)
                            app.playerId = data.playerId;

                        if (data.accounts) 
                            app.playerMoney = data.accounts;

                        if (data.weapon){
                            app.weapon = data.weapon+" - "+data.ammo+" balas";
                        } else {
                            app.weapon = null
                        }

                        if (data.vehicle){
                            app.vehicleSpeed = data.vehicleSpeed;
                        } else {
                            app.vehicleSpeed = 0;
                        }

                        if (data.fuel){
                            app.fuel = data.fuel;
                        } else {
                            app.fuel = 0;
                        }

                        if (data.vehicle) {
                            $('.needs').animate({bottom: '70px'});
                        } else {
                            $('.needs').animate({bottom: '20px'});
                        }

                        if (data.hunger)
                            app.hunger = data.hunger;

                        if (data.thirst)
                            app.thirst = data.thirst;

                        if (data.drunk)
                            app.drunk = data.drunk;

                        if (data.stress)
                            app.stress = data.stress;

                        app.mhz = data.mhz

                    default:
                        break;
                }
            }
        })
    }
})