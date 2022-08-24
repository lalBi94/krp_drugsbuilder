fx_version 'adamant'
game 'gta5'

lua54 'on'

author 'Zod#8682'
desc 'Drugs Builder Script ESX x RageUI'

client_scripts{
    "rui/RMenu.lua",
    "rui/menu/RageUI.lua",
    "rui/menu/Menu.lua",
    "rui/menu/MenuController.lua",
    "rui/components/*.lua",
    "rui/menu/elements/*.lua",
    "rui/menu/items/*.lua",
    "rui/menu/panels/*.lua",
    "rui/menu/windows/*.lua",
    'client/cl_main.lua',
    'client/config.lua'
}

server_scripts{
    'server/s_main.lua',
    '@mysql-async/lib/MySQL.lua'
}