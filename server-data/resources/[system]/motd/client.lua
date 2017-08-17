RegisterNetEvent('disclaimer:called')
AddEventHandler('disclaimer:called', function()
  Citizen.CreateThread(function()
    Wait(5000)
    local display = true
    local startTime = GetGameTimer()
    local delay = 60000 -- ms

    TriggerEvent('disclaimer:display', true)

    while display do
      Citizen.Wait(1)
      ShowInfo('~y~Lire attentivement.~w~ Appuyez sur ~INPUT_CONTEXT~ pour fermer.', 0)
      if (GetTimeDifference(GetGameTimer(), startTime) > delay) then
        display = false
        TriggerEvent('disclaimer:display', false)
      end
      if (IsControlJustPressed(1, 51)) then
        display = false
        TriggerEvent('disclaimer:display', false)
      end
    end
  end)
end)

RegisterNetEvent('disclaimer:display')
AddEventHandler('disclaimer:display', function(value)
  SendNUIMessage({
    type = "disclaimer",
    display = value
  })
end)

function ShowInfo(text, state)
  SetTextComponentFormat("STRING")
  AddTextComponentString(text)
  DisplayHelpTextFromStringLabel(0, state, 0, -1)
end