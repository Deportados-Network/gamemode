$(function () {
    var activeNotifications = [];

    window.addEventListener('message', function (event) {
        if (event.data.action == 'open') {
            // Cerrar notificación activa anterior, si hay alguna
            if (activeNotifications.length > 0) {
                var previousNotification = activeNotifications.shift();
                $(`.wrapper-${previousNotification}`).remove();
            }

            var number = Math.floor((Math.random() * 1000) + 1);
            $('.toast').append(`
            <div class="wrapper-${number}">
                <div class="notification_main-${number}">
                    <div class="title-${number}"></div>
                    <div class="text-${number}">
                        ${event.data.message}
                    </div>
                </div>
            </div>`)
            $(`.wrapper-${number}`).css({
                "margin-bottom": "10px",
                "width": "275px",
                "margin": "0 0 8px -180px",
                "border-radius": "10px"
            })
            $('.notification_main-'+number).addClass('main')
            $('.text-'+number).css({
                "font-size": "14px"
            })

            if (event.data.type == 'correcto') {
                $(`.title-${number}`).html(event.data.title).css({
                    "font-size": "16px",
                    "font-weight": "600"
                })
                $(`.notification_main-${number}`).addClass('correcto-icon')
                $(`.wrapper-${number}`).addClass('correcto correcto-border')
            } else if (event.data.type == 'general') {
                $(`.title-${number}`).html(event.data.title).css({
                    "font-size": "16px",
                    "font-weight": "600"
                })
                $(`.notification_main-${number}`).addClass('general-icon')
                $(`.wrapper-${number}`).addClass('general general-border')
            } else if (event.data.type == 'error') {
                $(`.title-${number}`).html(event.data.title).css({
                    "font-size": "16px",
                    "font-weight": "600"
                })
                $(`.notification_main-${number}`).addClass('error-icon')
                $(`.wrapper-${number}`).addClass('error error-border')
            } else if (event.data.type == 'advertencia') {
                $(`.title-${number}`).html(event.data.title).css({
                    "font-size": "16px",
                    "font-weight": "600"
                })
                $(`.notification_main-${number}`).addClass('advertencia-icon')
                $(`.wrapper-${number}`).addClass('advertencia advertencia-border')
            } else if (event.data.type == 'mensajes') {
                $(`.title-${number}`).html(event.data.title).css({
                    "font-size": "16px",
                    "font-weight": "600"
                })
                $(`.notification_main-${number}`).addClass('mensajes-icon')
                $(`.wrapper-${number}`).addClass('mensajes mensajes-border')
            } else if (event.data.type == 'textolargo') {
                $(`.title-${number}`).html(event.data.title).css({
                    "font-size": "16px",
                    "font-weight": "600"
                })
                $(`.notification_main-${number}`).addClass('textolargo-icon')
                $(`.wrapper-${number}`).addClass('textolargo textolargo-border')
            } else if (event.data.type == 'staff') {
                $(`.title-${number}`).html(event.data.title).css({
                    "font-size": "16px",
                    "font-weight": "600"
                })
                $(`.notification_main-${number}`).addClass('staff-icon')
                $(`.wrapper-${number}`).addClass('staff staff-border')
            } else if (event.data.type == 'desbloqueado') {
                $(`.title-${number}`).html(event.data.title).css({
                    "font-size": "16px",
                    "font-weight": "600"
                })
                $(`.notification_main-${number}`).addClass('desbloqueado-icon')
                $(`.wrapper-${number}`).addClass('desbloqueado desbloqueado-border')
            } else if (event.data.type == 'bloqueado') {
                $(`.title-${number}`).html(event.data.title).css({
                    "font-size": "16px",
                    "font-weight": "600"
                })
                $(`.notification_main-${number}`).addClass('bloqueado-icon')
                $(`.wrapper-${number}`).addClass('bloqueado bloqueado-border')
            } else if (event.data.type == 'sueldo') {
                $(`.title-${number}`).html(event.data.title).css({
                    "font-size": "16px",
                    "font-weight": "600"
                })
                $(`.notification_main-${number}`).addClass('sueldo-icon')
                $(`.wrapper-${number}`).addClass('sueldo sueldo-border')
            }
            
            anime({
                targets: `.wrapper-${number}`,
                translateX: -50,
                duration: 750,
                easing: 'spring(1, 70, 100, 10)',
            })

            activeNotifications.push(number);

            setTimeout(function () {
                anime({
                    targets: `.wrapper-${number}`,
                    translateX: 500,
                    duration: 750,
                    easing: 'spring(1, 80, 100, 0)'
                })
                setTimeout(function () {
                    $(`.wrapper-${number}`).remove();
                    // Remover la notificación activa del seguimiento
                    activeNotifications.shift();
                }, 750)
            }, event.data.time)
        }
    })
})
