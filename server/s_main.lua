ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Config = {}
Config.ACI = {
    Message = "~r~Ca cheat fort ici aiaiai DEHORS !",
    Range = 10,
    Contact = "~r~Please contact me on :\n~p~Zod#8682"
}

RegisterNetEvent("Zod#8682::CheckPerms")
RegisterNetEvent("Zod#8682::SetDrugs")
RegisterNetEvent("Zod#8682::GetCoordsPoints")
RegisterNetEvent("Zod#8682::RecoltDrug")
RegisterNetEvent("Zod#8682::TreatDrug")
RegisterNetEvent("Zod#8682::SellDrug")

AddEventHandler("Zod#8682::CheckPerms", function() 
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local steam = xPlayer.identifier

    MySQL.Async.fetchAll("SELECT permission_level FROM users WHERE identifier=@s", {["s"] = steam}, function(data) 
        if(data[1].permission_level >= 4) then
            TriggerClientEvent("Zod#8682::ReturnPermsChecker", _src, true)
        else
            TriggerClientEvent("Zod#8682::ReturnPermsChecker", _src, false)
        end
    end)
end)

AddEventHandler("Zod#8682::SetDrugs", function(name, label, price, coordsR, coordsT, coordsV)
    local _src = source

    local _n = name.."brute"
    local _l = label.." Brute"

    local _nt = name.."treat"
    local _lt = label.." Traité"

    local _price = price

    local _recolt = coordsR
    local _treat = coordsT
    local _sell = coordsV
    
    MySQL.Async.execute("INSERT INTO items(name, label) VALUES(@n, @l)", {["n"] = _n, ["l"] = _l})
    MySQL.Async.execute("INSERT INTO items(name, label) VALUES(@n, @l)", {["n"] = _nt, ["l"] = _lt})

    MySQL.Async.execute("INSERT INTO krp_drugsbuilder(name, label, nametreat, labeltreat, prix, xR, yR, zR, xT, yT, zT, xV, yV, zV) VALUES(@n, @l, @nt, @lt, @p, @xR, @yR, @zR, @xT, @yT, @zT, @xV, @yV, @zV)", {
        ["n"] = _n, 
        ["l"] = _l,
        ["nt"] = _nt,
        ["lt"] = _lt,
        ["p"] = _price, 
        ["xR"] = _recolt.x, ["yR"] = _recolt.y, ["zR"] = _recolt.z, 
        ["xT"] = _treat.x, ["yT"] = _treat.y, ["zT"] = _treat.z,
        ["xV"] = _sell.x, ["yV"] = _sell.y, ["zV"] = _sell.z,
    })

    TriggerClientEvent("esx:showNotification", _src, "La drogue : ~b~".._n.." a bien ete cree")
end)

AddEventHandler("Zod#8682::GetCoordsPoints", function() 
    local _src = source

    MySQL.Async.fetchAll("SELECT * FROM krp_drugsbuilder", {}, function(data) 
        local _d = data
        local all = {}

        for k, v in pairs(_d) do
            print("^4{Zod#8682} :: Actualisation du point de drogue : ".._d[k].label.."^0")

            table.insert (all, {
                name = _d[k].name,
                label = _d[k].label,
                treat = _d[k].nametreat,
                labelt = _d[k].labeltreat,
                price = _d[k].prix,
                r = vector3(_d[k].xR, _d[k].yR, _d[k].zR), 
                t = vector3(_d[k].xT, _d[k].yT, _d[k].zT), 
                v = vector3(_d[k].xV, _d[k].yV, _d[k].zV)
            })  
        end

        TriggerClientEvent("Zod#8682::ReceiveCoordsPoints", _src, all)
    end)
end)

AddEventHandler("Zod#8682::RecoltDrug", function(brut, vec) 
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local steam = xPlayer.identifier
    local brute = brut

    if(xPlayer ~= nil) then
        MySQL.Async.fetchAll("SELECT xR, yR, zR FROM krp_drugsbuilder WHERE name=@b", {["b"] = brute}, function(data)
            if(#(vector3(vec.x, vec.y, vec.z) - vector3(data[1].xR, data[1].yR, data[1].zR)) > Config.ACI.Range) then
                print("^4{Zod#8682} :: CHEAT DETECTION")
                print(steam.." cheat peut etre lol^0")
                TriggerClientEvent('esx:showNotification', _src, Config.ACI.Message)
                return
            else
                xPlayer.addInventoryItem(brute, 1)
            end
        end)
    else
        TriggerClientEvent("esx:showNotification", _src, Config.ACI.Contact)
    end
end)

AddEventHandler("Zod#8682::TreatDrug", function(brut, treat, vec) 
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local steam = xPlayer.identifier
    local itsPossible = xPlayer.getInventoryItem(brut).count
    local brute = brut
    local trait = treat

    if(xPlayer ~= nil) then
        MySQL.Async.fetchAll("SELECT xT, yT, zT FROM krp_drugsbuilder WHERE nametreat=@t", {["t"] = trait}, function(data)
            if(#(vector3(vec.x, vec.y, vec.z) - vector3(data[1].xT, data[1].yT, data[1].zT)) > Config.ACI.Range) then
                print("^4{Zod#8682} :: CHEAT DETECTION")
                print(steam.." cheat peut etre lol^0")
                TriggerClientEvent('esx:showNotification', _src, Config.ACI.Message)
            else
                if(itsPossible == 0 or itsPossible < 0) then
                    TriggerClientEvent('esx:showNotification', _src, "~r~Vous n'avez pas de "..brute)
                    return
                end
            
                if(itsPossible == 1) then
                    TriggerClientEvent('esx:showNotification', _src, "~r~Vous n'avez plus de "..brute)
                    return
                end

                xPlayer.removeInventoryItem(brute, 1)
                xPlayer.addInventoryItem(trait, 1)
            end
        end)
    else
        TriggerClientEvent("esx:showNotification", _src, Config.ACI.Contact)
    end
end)

AddEventHandler("Zod#8682::SellDrug", function(treat, price, vec) 
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local itsPossible = xPlayer.getInventoryItem(treat).count
    local prix = price
    local trait = treat

    if(xPlayer ~= nil) then
        MySQL.Async.fetchAll("SELECT xV, yV, zV FROM krp_drugsbuilder WHERE nametreat=@t", {["t"] = trait}, function(data)
            if(#(vector3(vec.x, vec.y, vec.z) - vector3(data[1].xV, data[1].yV, data[1].zV)) > Config.ACI.Range) then
                print("^4{Zod#8682} :: CHEAT DETECTION")
                print(steam.." cheat peut etre lol^0")
                TriggerClientEvent('esx:showNotification', _src, Config.ACI.Message)
            else
                if(itsPossible == 0 or itsPossible < 0) then
                    TriggerClientEvent('esx:showNotification', _src, "~r~Vous n'avez pas de "..trait)
                    return
                end
            
                if(itsPossible == 1) then
                    TriggerClientEvent('esx:showNotification', _src, "~r~Vous n'avez plus de "..trait)
                    return
                end

                xPlayer.removeInventoryItem(trait, 1)
                xPlayer.addAccountMoney('black_money', prix)
            end
        end)
    else
        TriggerClientEvent("esx:showNotification", _src, Config.ACI.Contact)
    end
end)