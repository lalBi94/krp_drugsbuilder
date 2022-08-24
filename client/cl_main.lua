RegisterNetEvent("Zod#8682::ReceiveCoordsPoints")
RegisterNetEvent("Zod#8682::ReturnPermsChecker")

-- function
function notif(msg)
    if Notification then 
      RemoveNotification(Notification)
    end 

    SetNotificationTextEntry("STRING") 
    AddTextComponentSubstringPlayerName(msg)
    Notification = DrawNotification(true, true)
end

function display() 
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        return result
    end
end

function DrawText3Ds(x, y, z, text, r, g, b, a)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(r, g, b, a)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function AddMarkerOnMap(name, label, treate, labeltreat, price, x1, y1, z1, x2, y2, z2, x3, y3, z3)
    local recolt = vector3(x1, y1, z1)
    local treat = vector3(x2, y2, z2)
    local sell = vector3(x3, y3, z3)
    local l = label
    local brut = name
    local trait = treate
    local prix = price

    if(#(recolt - GetEntityCoords(PlayerPedId(-1))) < Config.toBeVisible) then
        if(Config.inAction) then
            if(IsPedInAnyVehicle(PlayerPedId(-1))) then
                AddTextEntry("inveh", "~r~Veuillez descendre de votre vehicule !")
                DisplayHelpTextThisFrame("inveh", false)
            else
                AddTextEntry("recolt", "Appuyer sur ~INPUT_CONTEXT~ pour recolter : ~h~~r~"..l)
                DisplayHelpTextThisFrame("recolt", false)
            end
        end 
        
        if(not Config.inAction) then
            AddTextEntry("recolt", "Appuyer sur ~INPUT_JUMP~ pour arreter de recolter : ~h~~r~"..l)
            DisplayHelpTextThisFrame("recolt", false)
        end

        DrawMarker(2, recolt.x, recolt.y, recolt.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 170, 0, 1, 2, 0, nil, nil, 0)
        if(IsControlJustPressed(1, Config.keyInteract) and not IsPedInAnyVehicle(PlayerPedId(-1))) then
            Config.inAction = false
            if(name) then
                krp_drug("recolt", brut, "")
            end
        end
    end

    if(#(treat - GetEntityCoords(PlayerPedId(-1))) < Config.toBeVisible) then
        if(Config.inAction) then
            if(IsPedInAnyVehicle(PlayerPedId(-1))) then
                AddTextEntry("inveh", "~r~Veuillez descendre de votre vehicule !")
                DisplayHelpTextThisFrame("inveh", false)
            else
                AddTextEntry("treat", "Appuyer sur ~INPUT_CONTEXT~ pour traiter : ~h~~r~"..label)
                DisplayHelpTextThisFrame("treat", false)
            end
        end 
        
        if(not Config.inAction) then
            AddTextEntry("treat", "Appuyer sur ~INPUT_JUMP~ pour arreter de traiter : ~h~~r~"..label)
            DisplayHelpTextThisFrame("treat", false)
        end

        DrawMarker(2, treat.x, treat.y, treat.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 170, 0, 1, 2, 0, nil, nil, 0)
        if(IsControlJustPressed(1, Config.keyInteract) and not IsPedInAnyVehicle(PlayerPedId(-1))) then
            Config.inAction = false
            if(treate) then
                krp_drug("treatment", brut, trait)
            else
                notif(Config.Err)
            end
        end
    end

    if(#(sell - GetEntityCoords(PlayerPedId(-1))) < Config.toBeVisible) then
        if(Config.inAction) then
            if(IsPedInAnyVehicle(PlayerPedId(-1))) then
                AddTextEntry("inveh", "~r~Veuillez descendre de votre vehicule !")
                DisplayHelpTextThisFrame("inveh", false)
            else
                AddTextEntry("sell", "Appuyer sur ~INPUT_CONTEXT~ pour vendre : ~h~~r~"..labeltreat)
                DisplayHelpTextThisFrame("sell", false)
            end
        end 
        
        if(not Config.inAction) then
            AddTextEntry("sell", "Appuyer sur ~INPUT_JUMP~ pour arreter de vendre : ~h~~r~"..labeltreat)
            DisplayHelpTextThisFrame("sell", false)
        end

        DrawMarker(2, sell.x, sell.y, sell.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 170, 0, 1, 2, 0, nil, nil, 0)
        if(IsControlJustPressed(1, Config.keyInteract) and not IsPedInAnyVehicle(PlayerPedId(-1))) then
            Config.inAction = false
            if(price and treate) then
                krp_drug("sell", "", trait, prix)
            else
                notif(Config.Err)
            end
        end
    end
end

function krp_drug(action, brut, treat, price) -- action = recolt, treatment, sell
    local playerPed = PlayerPedId(-1)
    local playerPos = GetEntityCoords(playerPed)
    local delay = 2000
    Config.toggleFocusOn = true

    if(action == "recolt") then
        Citizen.CreateThread(function()
            while(Config.toggleFocusOn) do
                Citizen.CreateThread(function() 
                    while(true) do
                        Citizen.Wait(1)
                
                        if(IsControlJustPressed(1, Config.keyStopInteract)) then
                            remove(Config.anim.recolt.animation)
                            FreezeEntityPosition(playerPed, false)
                            Config.inAction = true
                            Config.toggleFocusOn = false
                        end
                    end
                end)
                
                RequestAnimDict(Config.anim.recolt.animation)
                while (not HasAnimDictLoaded(Config.anim.recolt.animation)) do
                    Citizen.Wait(0)
                end

                TaskPlayAnim(playerPed, Config.anim.recolt.animation, Config.anim.recolt.name, 8.0, 8.0, 3000, 48, 1, false, false, false)
                FreezeEntityPosition(playerPed, true)
                Citizen.Wait(delay)
                remove(Config.anim.recolt.animation)

                TriggerServerEvent(Config.TriggerRecolt, brut, playerPos)

                Citizen.Wait(1)
            end
        end)
    end

    if(action == "treatment") then
        Citizen.CreateThread(function()
            while(Config.toggleFocusOn) do
                Citizen.CreateThread(function() 
                    while(true) do
                        Citizen.Wait(1)
                
                        if(IsControlJustPressed(1, Config.keyStopInteract)) then
                            remove(Config.anim.recolt.animation)
                            FreezeEntityPosition(playerPed, false)
                            Config.inAction = true
                            Config.toggleFocusOn = false
                        end
                    end
                end)
                
                RequestAnimDict(Config.anim.recolt.animation)
                while (not HasAnimDictLoaded(Config.anim.recolt.animation)) do
                    Citizen.Wait(0)
                end

                TaskPlayAnim(playerPed, Config.anim.recolt.animation, Config.anim.recolt.name, 8.0, 8.0, 3000, 48, 1, false, false, false)
                FreezeEntityPosition(playerPed, true)
                Citizen.Wait(delay)
                remove(Config.anim.recolt.animation)

                TriggerServerEvent(Config.TriggerTreat, brut, treat, playerPos)

                Citizen.Wait(1)
            end
        end)
    end

    if(action == "sell") then
        Citizen.CreateThread(function()
            while(Config.toggleFocusOn) do
                Citizen.CreateThread(function() 
                    while(true) do
                        Citizen.Wait(1)
                
                        if(IsControlJustPressed(1, Config.keyStopInteract)) then
                            remove(Config.anim.recolt.animation)
                            FreezeEntityPosition(playerPed, false)
                            Config.inAction = true
                            Config.toggleFocusOn = false
                        end
                    end
                end)
                
                RequestAnimDict(Config.anim.recolt.animation)
                while (not HasAnimDictLoaded(Config.anim.recolt.animation)) do
                    Citizen.Wait(0)
                end

                TaskPlayAnim(playerPed, Config.anim.recolt.animation, Config.anim.recolt.name, 8.0, 8.0, 3000, 48, 1, false, false, false)
                FreezeEntityPosition(playerPed, true)
                Citizen.Wait(delay)
                remove(Config.anim.recolt.animation)

                TriggerServerEvent(Config.TriggerSell, treat, price, playerPos)

                Citizen.Wait(1)
            end
        end)
    end
end

function remove(anim) 
    RemoveAnimDict(anim)
end

-- menu
function menu() 
    Citizen.CreateThread(function() 
        local menu = RageUI.CreateMenu("Lumisia RP", Config.Sub, 250, 250)
        RageUI.Visible(menu, not RageUI.Visible(menu))

        while(menu) do
            Citizen.Wait(0)
            DrawText3Ds(Config.exp.coordsr.x, Config.exp.coordsr.y, Config.exp.coordsr.z, Config.Menu.Marker.Text.r, 255, 255, 255, 255)
            DrawMarker(Config.Menu.Marker.Type, Config.exp.coordsr.x, Config.exp.coordsr.y, Config.exp.coordsr.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 170, 0, 1, 2, 0, nil, nil, 0)

            DrawText3Ds(Config.exp.coordst.x, Config.exp.coordst.y, Config.exp.coordst.z, Config.Menu.Marker.Text.t, 255, 255, 255, 255)
            DrawMarker(Config.Menu.Marker.Type, Config.exp.coordst.x, Config.exp.coordst.y, Config.exp.coordst.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 170, 0, 1, 2, 0, nil, nil, 0)

            DrawText3Ds(Config.exp.coordsv.x, Config.exp.coordsv.y, Config.exp.coordsv.z, Config.Menu.Marker.Text.v, 255, 255, 255, 255)
            DrawMarker(Config.Menu.Marker.Type, Config.exp.coordsv.x, Config.exp.coordsv.y, Config.exp.coordsv.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 170, 0, 1, 2, 0, nil, nil, 0)

            RageUI.IsVisible(menu, function() 
                RageUI.Button(Config.Menu.Button.Title, Config.exp.nom, { RightLabel = Config.exp.nom }, true, {onSelected = function()
                    Config.exp.nom = display()
                end, onActive = function() end})

                RageUI.Button(Config.Menu.Button.Label, Config.exp.label, { RightLabel = Config.exp.label}, true, {onSelected = function()
                    Config.exp.label = display()
                end, onActive = function() end})

                RageUI.Button(Config.Menu.Button.CoordsR, Config.exp.coordsr.x..",\n"..Config.exp.coordsr.y..",\n"..Config.exp.coordsr.z, { RightLabel = ""}, true, {onSelected = function()
                    local coords = GetEntityCoords(PlayerPedId(-1))
                    Config.exp.coordsr.x = coords.x
                    Config.exp.coordsr.y = coords.y
                    Config.exp.coordsr.z = coords.z
                end, onActive = function() end})

                RageUI.Button(Config.Menu.Button.CoordsT, Config.exp.coordst.x..",\n"..Config.exp.coordst.y..",\n"..Config.exp.coordst.z, { RightLabel = ""}, true, {onSelected = function()
                    local coords2 = GetEntityCoords(PlayerPedId(-1))
                    Config.exp.coordst.x = coords2.x
                    Config.exp.coordst.y = coords2.y
                    Config.exp.coordst.z = coords2.z
                end, onActive = function() end})

                RageUI.Button(Config.Menu.Button.CoordsV, Config.exp.coordsv.x..",\n"..Config.exp.coordsv.y..",\n"..Config.exp.coordsv.z, { RightLabel = ""}, true, {onSelected = function()
                    local coords3 = GetEntityCoords(PlayerPedId(-1))
                    Config.exp.coordsv.x = coords3.x
                    Config.exp.coordsv.y = coords3.y
                    Config.exp.coordsv.z = coords3.z
                end, onActive = function() end})

                RageUI.Button(Config.Menu.Button.Price, Config.exp.price, { RightLabel = Config.exp.price}, true, {onSelected = function()
                    Config.exp.price = display()
                end, onActive = function() end})

                RageUI.Separator(" ")

                RageUI.Button(Config.Menu.Button.Confirmation, nil, { RightLabel = "✅"}, true, {onSelected = function()
                    vec1 = vector3(Config.exp.coordsr.x, Config.exp.coordsr.y, Config.exp.coordsr.z)
                    vec2 = vector3(Config.exp.coordst.x, Config.exp.coordst.y, Config.exp.coordst.z)
                    vec3 = vector3(Config.exp.coordsv.x, Config.exp.coordsv.y, Config.exp.coordsv.z)
                    TriggerServerEvent("Zod#8682::SetDrugs", Config.exp.nom, Config.exp.label, Config.exp.price, vec1, vec2, vec3)
                    TriggerServerEvent("Zod#8682::GetCoordsPoints")
                    RageUI.CloseAll()
                end, onActive = function() end})
            end)

            if(not RageUI.Visible(menu)) then
                menu = RMenu:DeleteType(menu, true)
            end
        end
    end)
end

-- back
Citizen.CreateThread(function() 
    TriggerServerEvent("Zod#8682::GetCoordsPoints")
    local data = {}
    print("^6Zod#8682 ^0:: for :: ^5Dream^0Role^1Play")

    AddEventHandler("Zod#8682::ReceiveCoordsPoints", function(all) 
        data = all
    end)

    while true do
        Citizen.Wait(0)
        for k, v in pairs(data) do
            AddMarkerOnMap(v.name , v.label, v.treat, v.labelt, v.price, v.r.x, v.r.y, v.r.z, v.t.x, v.t.y, v.t.z, v.v.x, v.v.y, v.v.z)
        end
    end
end)

RegisterCommand("drugsbuilder", function() 
    TriggerServerEvent("Zod#8682::CheckPerms")
    AddEventHandler("Zod#8682::ReturnPermsChecker", function(check) 
        if(check) then
            TriggerServerEvent("Zod#8682::GetCoordsPoints")
            menu()
        else
            notif("~r~Permission inssufisante")
        end
    end)
end, false)