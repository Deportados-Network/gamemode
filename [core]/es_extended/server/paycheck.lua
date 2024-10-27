function StartPayCheck()
  CreateThread(function()
    while true do
      Wait(Config.PaycheckInterval)

      for player, xPlayer in pairs(ESX.Players) do
        local job = xPlayer.job.grade_name
        local salary = xPlayer.job.grade_salary

        if salary > 0 then
          if job == 'unemployed' then -- unemployed
            
          elseif Config.EnableSocietyPayouts then -- possibly a society
            TriggerEvent('esx_society:getSociety', xPlayer.job.name, function(society)
              if society ~= nil then -- verified society
                TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
                  if account.money >= salary then -- does the society money to pay its employees?
                    xPlayer.addAccountMoney('bank', salary, "Paycheck")
                    account.removeMoney(salary)

                    xPlayer.showNotification("Has recibido tu sueldo de " .. salary .. "$")
                  else
                    xPlayer.showNotification("No hay dinero en la compañia")
                  end
                end)
              else -- not a society
                xPlayer.showNotification("Has recibido tu sueldo de " .. salary .. "$")
                xPlayer.addAccountMoney('bank', salary, "Paycheck")
              end
            end)
          else -- generic job
            xPlayer.addAccountMoney('bank', salary, "Paycheck")

            if (job ~= "police" and job ~= "ambulance") then
              xPlayer.showNotification("Has recibido tu sueldo de " .. salary .. "$")
            end
          end
        end
      end
    end
  end)
end
