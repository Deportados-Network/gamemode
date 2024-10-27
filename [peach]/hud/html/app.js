
/* HUD */
window.addEventListener("message", function(event) {
    var v = event.data
    // let formatodinero = Intl.NumberFormat('es-ES');
    let formatodinero = Intl.NumberFormat('en-US');


    switch (v.action) {
        case 'update': 
            $('.todoelHUd').show()
            // $('.comida i').css('background', `-webkit-linear-gradient(90deg, #ECC94B 0%, #ECC94B ${v.food}%, rgba(255, 255, 255, 1) ${v.food}%)`);
            // $('.bebida i').css('background', `-webkit-linear-gradient(90deg, #2C5282 0%, #2C5282 ${v.water}%, rgba(255, 255, 255, 1) ${v.water}%)`);
            // $('.barcomida').css({'width': `${v.food}%`})
            // $('.barsed').css({'width': `${v.water}%`})

            
            $('.comida i').css('background', `-webkit-linear-gradient(90deg, #ECC94B 0%, #ECC94B ${v.food}%, rgba(255, 255, 255, 1) ${v.food}%)`)
            $('.comida i').css('-webkit-background-clip', 'text')
            $('.comida i').css('-webkit-text-fill-color', 'transparent')

            $('.bebida i').css('background', `-webkit-linear-gradient(90deg, #2C5282 0%, #2C5282 ${v.water}%, rgba(255, 255, 255, 1) ${v.water}%)`)
            $('.bebida i').css('-webkit-background-clip', 'text')
            $('.bebida i').css('-webkit-text-fill-color', 'transparent')

            
            $('.laid').text('#'+v.pid)
            $('.elnombre').text(' '+v.nombre)


        
            startClockThread()
            if (v.talking == true) {
                $('#microJs').addClass('active')
            } else {
                $('#microJs').removeClass('active')
            }
        break;


        case 'mugshotes':
            $('.mugshot').attr('src', `https://nui-img/${v.img}/${v.img}`)
        break;

        case 'showCarhud': 
            $('.autitohud').fadeIn(500)

            $('.numspeed p').text(v.vel.toFixed(0))
            $('.textmotor p').text(v.carhealth.toFixed(0)+'%')
            $('.gasolina p').text(v.gasolina.toFixed(0)+'L')

        
            if (v.cinturon == true) {
                $('.cinturon').css('fill', 'rgb(0, 143, 57)')
                $('.cinturon').css('opacity', '1')
                $('.cinturon').css('animation', 'none')
                $('.cinturon').css('fill', 'rgb(0, 143, 57)');
               
            } else {
                $('.cinturon').css('opacity', '1')
                $('.cinturon').css('animation', 'pulso 1s infinite')
                $('.cinturon').css('fill', 'rgb(172, 0, 0)');
            }

        break;

        case 'hideCarhud':
                $('.autitohud').fadeOut(250)
        break;
        


        case 'UpdateMoney': 
                $('.moneyjs').html(`${formatodinero.format(v.money)}`)
                $('.bankjs').html(`${formatodinero.format(v.bank)}`)
                $('.coinsjs').html(`${formatodinero.format(v.coins)}`)
                $('.black_moneyjs').html(`${formatodinero.format(v.black_money)}`)
        break;


        case 'UpdateJob':
            // $('.job').text(`${v.job}: ${v.jobb}`);
            $('.job').text(`${v.job} - ${v.jobb}`);
        break;        

        case 'UpdateVoice':

            var voiceId = document.querySelector('.voiceDistance');

            var voiceIdWithClasses = voiceId.classList;

            // if(v.value == 'Susurrar'){
            //     voiceId.style.fill = "rgb(255, 230, 0) !important;";
            // }else if(v.value == 'Normal'){
            //     voiceId.style.fill = "rgb(0, 204, 17) !important";
            // }else if(v.value == "Gritar"){
            //     voiceId.style.fill = "rgb(255, 81, 0) !important";
            // }

            voiceIdWithClasses.remove('Susurrar', 'Normal', 'Gritar');
            voiceIdWithClasses.add(v.value);
        break;

        case 'hideAllHud': 
            $('.todoelHUd').hide()
        break;

// OCULTAR / VER HUD CON /hud
        case 'OcultarHud':
            $('.economia').hide()
            $('.trabajo').hide()
            $('.cont-alimentos').hide()
            // $('.arribademinimapa').hide()
        break;
        case 'VerHud':
            $('.economia').show()
            $('.trabajo').show()
            $('.cont-alimentos').show()
            // $('.arribademinimapa').show()
        break;
// OCULTAR / VER HUD CON /hud
    }
})

// function imgError(img) {
//     img.error="";
//     img.src="https://media.tenor.com/On7kvXhzml4AAAAj/loading-gif.gif";
// }