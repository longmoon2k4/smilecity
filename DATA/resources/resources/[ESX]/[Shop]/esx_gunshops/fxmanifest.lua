



--[[ fxmanifest ]]

fx_version 'adamant'

game {'gta5'}

author 'Sulu'

description 'Cửa Hàng Súng'

version '1.0.0'

client_scripts {
    "config.lua",
    "warmenu.lua",
    "client.lua"
}
server_scripts {
    "config.lua",
    "server.lua"
}

dependencies {
    "es_extended"
}
shared_script '@es_extended/imports.lua'