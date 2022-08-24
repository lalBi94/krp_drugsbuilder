Config = {}

-- relativ to menu
Config.Title = "Dream ~p~~b~RP"
Config.Sub = " "
Config.PointList = {}
Config.Menu = {}
Config.Menu.Button = {}
Config.Menu.Marker = {}
Config.Menu.Button.Label = "Label de la drogue"
Config.Menu.Button.Title = "Nom de la drogue"
Config.Menu.Button.CoordsR = "Coordonnees Recolte"
Config.Menu.Button.CoordsT = "Coordonnees Traitement"
Config.Menu.Button.CoordsV = "Coordonnees Vente"
Config.Menu.Button.Price = "Prix"
Config.Menu.Button.Confirmation = "Valider"

-- relativ to interaction
Config.keyInteract = 51 -- (E)
Config.keyStopInteract = 22 -- (SPACE)
Config.inAction = true
Config.toBeVisible = 3
Config.Menu.Marker.Type = 0 
Config.Menu.Marker.Text = {r = "Point de Recole", t = "Point de Traitement", v = "Point de Vente"} 
Config.toggleFocusOn = true
Config.Err = "~r~Please contact me on :\n~p~Zod#8682"

-- relativ to triggers
Config.TriggerRecolt = "Zod#8682::RecoltDrug"
Config.TriggerTreat = "Zod#8682::TreatDrug"
Config.TriggerSell = "Zod#8682::SellDrug"

Config.anim = {
    recolt = {
        animation = "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", 
        name = "plant_floor"
    }
}

-- relativ to stock data
Config.exp = {
    nom = "", 
    label = "", 
    coordsr = {x="", y = "", z = ""}, 
    coordst = {x="", y = "", z = ""}, 
    coordsv = {x="", y = "", z = ""}, 
    price = ""
}