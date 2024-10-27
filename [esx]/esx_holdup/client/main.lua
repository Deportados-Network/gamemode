local holdingUp = false
local store = ''
local blipRobbery = nil

function DrawTxt(x,y, width, height, scale, text, r, g, b, a, outline)
	SetTextFont(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropshadow(0, 0, 0, 0,255)
	SetTextDropShadow()
	if outline then
        SetTextOutline()
    end
	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x - width / 2, y - height / 2 + 0.005)
end

RegisterNetEvent('esx_holdup:currentlyRobbing')
AddEventHandler('esx_holdup:currentlyRobbing', function(currentStore)
	holdingUp, store = true, currentStore
end)

RegisterNetEvent('esx_holdup:killBlip')
AddEventHandler('esx_holdup:killBlip', function()
	RemoveBlip(blipRobbery)
end)

RegisterNetEvent('esx_holdup:setBlip')
AddEventHandler('esx_holdup:setBlip', function(position)
	blipRobbery = AddBlipForCoord(position)
	SetBlipSprite(blipRobbery, 161)
	SetBlipScale(blipRobbery, 1.5)
	SetBlipColour(blipRobbery, 3)
	PulseBlip(blipRobbery)
end)

RegisterNetEvent('esx_holdup:tooFar')
AddEventHandler('esx_holdup:tooFar', function()
	store = ''
	ESX.ShowNotification(TranslateCap('robbery_cancelled'))
end)

RegisterNetEvent('esx_holdup:robberyComplete')
AddEventHandler('esx_holdup:robberyComplete', function(award)
	holdingUp, store = false, ''
	ESX.ShowNotification(TranslateCap('robbery_complete', award))
end)

RegisterNetEvent('esx_holdup:startTimer')
AddEventHandler('esx_holdup:startTimer', function()
	local timer = Stores[store].secondsRemaining
	CreateThread(function()
		while timer > 0 and holdingUp do
			Wait(1000)
			if timer > 0 then
				timer = timer - 1
			end
		end
	end)
	CreateThread(function()
		while holdingUp do
			Wait(0)
			DrawTxt(0.66, 1.44, 0.7, 0.7, 0.4, TranslateCap('robbery_timer', timer), 255, 255, 255, 255)
		end
	end)
end)


/* BLIPS | ROBOS */

CreateThread(function()
	local bancoBlip = AddBlipForCoord(254.6831, 226.0766, 101.8757)
	SetBlipSprite(bancoBlip, 106)
	SetBlipScale(bancoBlip, 0.7)
	SetBlipColour(bancoBlip, 0)

	SetBlipAsShortRange(bancoBlip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Banco Central')
	EndTextCommandSetBlipName(bancoBlip)
end)

CreateThread(function()
	local pfaBlip = AddBlipForCoord(-1116.47, -834.86, 19.32)
	SetBlipSprite(pfaBlip, 60)
	SetBlipScale(pfaBlip, 0.9)
	SetBlipColour(pfaBlip, 3)
	SetBlipAsShortRange(pfaBlip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Estación de PFA')
	EndTextCommandSetBlipName(pfaBlip)
end)

CreateThread(function()
	local gendarme = AddBlipForCoord(-444.7532, 6014.0713, 31.7164)
	SetBlipSprite(gendarme, 60)
	SetBlipScale(gendarme, 0.9)
	SetBlipColour(gendarme, 25)
	SetBlipAsShortRange(gendarme, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Gendarmeria')
	EndTextCommandSetBlipName(gendarme)
end)

CreateThread(function()
	local mazeBlip = AddBlipForCoord(-1302.553833, -824.584595, 17.147949)
	SetBlipSprite(mazeBlip, 124)
	SetBlipScale(mazeBlip, 0.7)
	SetBlipColour(mazeBlip, 0)

	SetBlipAsShortRange(bancoBlip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('MazeBank')
	EndTextCommandSetBlipName(mazeBlip)
end)

CreateThread(function()
	local gordoBlip = AddBlipForCoord(141.84, -1093.65, 29.41)
	SetBlipSprite(gordoBlip, 446)
	SetBlipScale(gordoBlip, 0.9)
	SetBlipColour(gordoBlip, 5)
	SetBlipAsShortRange(gordoBlip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Meca GordoTunning')
	EndTextCommandSetBlipName(gordoBlip)
end)

CreateThread(function()
	local lifeBlip = AddBlipForCoord(-1051.8416, -232.3258, 44.0209) 
	SetBlipSprite(lifeBlip, 77)
	SetBlipScale(lifeBlip, 0.7)
	SetBlipColour(lifeBlip, 0)

	SetBlipAsShortRange(lifeBlip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Life-Invader')
	EndTextCommandSetBlipName(lifeBlip)
end)

CreateThread(function()
	local chickenBlip = AddBlipForCoord(-70.087906, 6241.622070, 31.065918) 
	SetBlipSprite(chickenBlip, 89)
	SetBlipScale(chickenBlip, 0.7)
	SetBlipColour(chickenBlip, 0)

	SetBlipAsShortRange(chickenBlip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Chicken')
	EndTextCommandSetBlipName(chickenBlip)
end)

CreateThread(function()
	local gnaBlip = AddBlipForCoord(1848.4, 3690.24, 34.27)
	SetBlipSprite(gnaBlip, 60) 
	SetBlipScale(gnaBlip, 0.9)
	SetBlipColour(gnaBlip, 52)
	SetBlipAsShortRange(gnaBlip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Gendarmeria')
	EndTextCommandSetBlipName(gnaBlip)
end)

CreateThread(function()
	local yateBlip = AddBlipForCoord(-2090.1274, -1016.7029, 8.9712)
	SetBlipSprite(yateBlip, 455)
	SetBlipScale(yateBlip, 0.7)
	SetBlipColour(yateBlip, 0)

	SetBlipAsShortRange(yateBlip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Yate')
	EndTextCommandSetBlipName(yateBlip)
end)

CreateThread(function()
	local mecaBlip = AddBlipForCoord(-205.58, -1322.71, 30.9)
	SetBlipSprite(mecaBlip, 446)
	SetBlipScale(mecaBlip, 0.9)
	SetBlipColour(mecaBlip, 5)
	SetBlipAsShortRange(mecaBlip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Mecanico')
	EndTextCommandSetBlipName(mecaBlip)
end)

-- CreateThread(function()
-- 	local polleriaBlip = AddBlipForCoord(-68.6304, 6255.3022, 31.0902)
-- 	SetBlipSprite(polleriaBlip, 108)
-- 	SetBlipScale(polleriaBlip, 0.7)
-- 	SetBlipColour(polleriaBlip, 0)

-- 	SetBlipAsShortRange(polleriaBlip, true)
-- 
-- 	BeginTextCommandSetBlipName('STRING')
-- 	AddTextComponentString('Polleria')
-- 	EndTextCommandSetBlipName(polleriaBlip)
-- end)

Citizen.CreateThread(function()
    -- Obtén las coordenadas donde deseas colocar el Blip
    local blipPos = vector3(-842.0554, -124.7008, 28.1850) -- Reemplaza las coordenadas con las que desees
    
    -- Crea el Blip en el mapa
    local blip = AddBlipForCoord(blipPos.x, blipPos.y, blipPos.z)
    
    -- Configura el aspecto del Blip
    SetBlipSprite(blip, 293) -- Elige el sprite del Blip (en este caso, 1 es el sprite de una casa)
    SetBlipDisplay(blip, 4) -- Configura cómo se muestra el Blip en el mapa (4 es una opción común)
    SetBlipScale(blip, 0.7) -- Configura el tamaño del Blip (puedes ajustarlo según tus preferencias)
    SetBlipColour(blip, 0)
 -- Configura el color del Blip (en este caso, 2 es el color verde)
    SetBlipAsShortRange(blip, true) -- Configura el rango de visualización del Blip
    
    -- Configura el texto del Blip
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Subte") -- Reemplaza "Mi Blip" con el texto que desees mostrar en el Blip
    EndTextCommandSetBlipName(blip)
end)
CreateThread(function()
	local joyeriaBlip = AddBlipForCoord(-621.9808, -230.7023, 38.0571)
	SetBlipSprite(joyeriaBlip, 617)
	SetBlipScale(joyeriaBlip, 0.7)
	SetBlipColour(joyeriaBlip, 0)

	SetBlipAsShortRange(joyeriaBlip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Joyeria')
	EndTextCommandSetBlipName(joyeriaBlip)
end)

CreateThread(function()
	local fleccamecaBlip = AddBlipForCoord(-355.226379, -53.591209, 49.044678)
	SetBlipSprite(fleccamecaBlip, 108)
	SetBlipScale(fleccamecaBlip, 0.7)
	SetBlipColour(fleccamecaBlip, 0)

	SetBlipAsShortRange(fleccamecaBlip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Flecca BBVA')
	EndTextCommandSetBlipName(fleccamecaBlip)
end)

CreateThread(function()
	local ayuntaBlip = AddBlipForCoord(310.127472, -282.778015, 54.166992)
	SetBlipSprite(ayuntaBlip, 108)
	SetBlipScale(ayuntaBlip, 0.7)
	SetBlipColour(ayuntaBlip, 0)

	SetBlipAsShortRange(ayuntaBlip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Flecca BBVA')
	EndTextCommandSetBlipName(ayuntaBlip)
end)

CreateThread(function()
	local fleccacostaBlip = AddBlipForCoord(-2958.013184, 479.841766, 15.698853)
	SetBlipSprite(fleccacostaBlip, 108)
	SetBlipScale(fleccacostaBlip, 0.7)
	SetBlipColour(fleccacostaBlip, 0)

	SetBlipAsShortRange(fleccacostaBlip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Flecca BBVA')
	EndTextCommandSetBlipName(fleccacostaBlip)
end)

CreateThread(function()
	local fleccasandyBlip = AddBlipForCoord(1177.476929, 2711.709961, 38.092285)
	SetBlipSprite(fleccasandyBlip, 108)
	SetBlipScale(fleccasandyBlip, 0.7)
	SetBlipColour(fleccasandyBlip, 0)

	SetBlipAsShortRange(fleccasandyBlip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Flecca BBVA')
	EndTextCommandSetBlipName(fleccasandyBlip)
end)

CreateThread(function()
	local bancopaletoBlip = AddBlipForCoord(-106.720879, 6473.723145, 31.621948)
	SetBlipSprite(bancopaletoBlip, 108)
	SetBlipScale(bancopaletoBlip, 0.7)
	SetBlipColour(bancopaletoBlip, 0)

	SetBlipAsShortRange(bancopaletoBlip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Banco Paleto')
	EndTextCommandSetBlipName(bancopaletoBlip)
end)

CreateThread(function()
	local electricaBlip = AddBlipForCoord(743.353882, 1284.685669, 360.294434)
	SetBlipSprite(electricaBlip, 354)
	SetBlipScale(electricaBlip, 1.2)
	SetBlipColour(electricaBlip, 5)
	SetBlipAsShortRange(electricaBlip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Electrica')
	EndTextCommandSetBlipName(electricaBlip)
end)

CreateThread(function()
	local michaelBlip = AddBlipForCoord(-813.204407, 179.353851, 72.145752)
	SetBlipSprite(michaelBlip, 124)
	SetBlipScale(michaelBlip, 0.7)
	SetBlipColour(michaelBlip, 0)

	SetBlipAsShortRange(michaelBlip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('casa michael')
	EndTextCommandSetBlipName(michaelBlip)
end)

CreateThread(function()
	local humaneBlip = AddBlipForCoord(3599.1853, 3722.1316, 29.6894)
	SetBlipSprite(humaneBlip, 108)
	SetBlipScale(humaneBlip, 0.7)
	SetBlipColour(humaneBlip, 0)

	SetBlipAsShortRange(humaneBlip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Humane')
	EndTextCommandSetBlipName(humaneBlip)
end)


-- CreateThread(function()
-- 	local cayoBlip = AddBlipForCoord(5013.29, -5751.79, 15.48)
-- 	SetBlipSprite(cayoBlip, 108)
-- 	SetBlipScale(cayoBlip, 0.7)
-- 	SetBlipColour(cayoBlip, 0)

-- 	SetBlipAsShortRange(cayoBlip, true)
-- 
-- 	BeginTextCommandSetBlipName('STRING')
-- 	AddTextComponentString('Cayo Perico')
-- 	EndTextCommandSetBlipName(cayoBlip)
-- end)

CreateThread(function()
	local portavionesBlip = AddBlipForCoord(3081.71, -4704.85, 15.26)
	SetBlipSprite(portavionesBlip, 16)
	SetBlipScale(portavionesBlip, 0.7)
	SetBlipColour(portavionesBlip, 0)

	SetBlipAsShortRange(portavionesBlip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Porta Aviones')
	EndTextCommandSetBlipName(portavionesBlip)
end)

/* ------------ */

CreateThread(function()
	while true do
		Wait(0)
		local playerPos, letSleep = GetEntityCoords(PlayerPedId()), true
		for k,v in pairs(Stores) do
			local distance = #(playerPos - v.position)
			if distance < Config.Marker.DrawDistance then
				if not holdingUp then
                    letSleep = false
					DrawMarker(Config.Marker.Type, v.position, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, false, false, false, false)
					if distance < 2.0 then
						ESX.ShowFloatingHelpNotification("~r~[E]~w~ Iniciar robo", vec3(Config.Marker.x, Config.Marker.y, Config.Marker.z))
						if IsControlJustReleased(0, 38) then
							if IsPedArmed(PlayerPedId(), 4) then
								TriggerServerEvent('esx_holdup:robberyStarted', k)
							else
								ESX.ShowNotification('No puedes robar nada sin un arma en mano!', 3500)
							end
						end
					end
				end
                break
			else
				letSleep = true
			end
		end
		if holdingUp then
            letSleep = false
			if #(playerPos - Stores[store].position) > Config.MaxDistance then
				TriggerServerEvent('esx_holdup:tooFar', store)
				holdingUp, letSleep = false, true
			end
		end
        if letSleep then
            Wait(500)
        end
	end
end)