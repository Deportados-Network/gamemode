
ESX = nil
local esmicoche = nil
local oferta = nil
local modelosbanned = {'wald2018','bug300ss','ZENTORNO','hevo','m4com','DC5','svj63','e63s','gle450','m3e46','675lt','yzfr6','Imola','r8v10abt','cayman','g65amg','apollo','centenario11','panamera17turbo','rs62','18Velar','lamboavj','nitroboost','BUGATTI','kamacho'}

Citizen.CreateThread(function()
  while ESX == nil do
    ESX = exports["es_extended"]:getSharedObject()
    Citizen.Wait(0)
  end
end)

function notificacion(texto)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(texto)
    DrawNotification(false, true)
end


AddEventHandler('playerSpawned',function()
end)


RegisterNetEvent('vender:compruebocoche') 
AddEventHandler('vender:compruebocoche',function(id,precio)

	local coords1 = GetEntityCoords(GetPlayerPed(PlayerId()))

	local coords2 = GetEntityCoords(GetPlayerPed(GetPlayerServerId(id)))

		if GetDistanceBetweenCoords(coords1,coords2) < 1.5 then
			if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 	
				local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
				local matr =  GetVehicleNumberPlateText(vehicle)
				local isbanned = false
				for i = 1, #modelosbanned,1 do
					Citizen.Trace(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
					Citizen.Trace(modelosbanned[i])
					if GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)) == modelosbanned[i] then 
						isbanned = true
						break
					end
				end
				if isbanned == true then
					TriggerEvent('chatMessage',"Vendedor", {255, 0, 0}, "Este coche no se puede vender")
					isbanned = false
				else

					TriggerServerEvent('vender:esmicoche',matr,id,precio,vehicle,GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))	
				end
			else
				TriggerEvent('chatMessage',"Vendedor", {255, 0, 0}, "Debes estar subido al coche que quieres vender")
			end
	else
		print("prueba")
	end
end)

RegisterNetEvent('vender:esmicochecallback')
AddEventHandler('vender:esmicochecallback',function(var,id,precio,matr,car,name)

	if var == true then
		TriggerEvent('chatMessage',"Vendedor", {255, 0, 0}, "Esperando a la respuesta del comprador...")
		TriggerServerEvent('vender:vendococheser',id,precio,matr,car,name)
	else
		TriggerEvent('chatMessage',"Vendedor", {255, 0, 0}, "Este coche no es tuyo")

	end

end)

TriggerEvent('chat:addSuggestion', '/vendercoche', 'Usa este comando para transferir el vehiculo en el que estas montado', {
    { name="ID", help="[ID]" },
    { name="Precio", help="[Mayor de 10000€]" }
})


RegisterNetEvent('vender:vendocoche') --El que recibe la oferta
AddEventHandler('vender:vendocoche',function(price,jugador,matr,vehicle,name)

	TriggerEvent('chatMessage',"Vendedor", {255, 0, 0},"La ID("..jugador..") te quiere vender su ^2 "..name.."^0 por ^2 "..price.." $")
	TriggerEvent('chatMessage',"Vendedor", {255, 0, 0},"^2 TECLA 1 ^0 para ACEPTAR o ^2 TECLA 2 ^0 para rechazar la oferta")
	oferta = true
	Citizen.CreateThread(function()
		while oferta do
				if IsControlJustPressed(1, 157) then -- 1 = YES
					TriggerServerEvent('vender:handleroferta',true,jugador,matr,price,name)
					oferta = false
				end
				if IsControlJustPressed(1, 158) then -- 2 = NO
					TriggerServerEvent('vender:handleroferta',false,jugador,matr,price,name)
					oferta = false
				end
			Citizen.Wait(0)
		end
	end)


end)


