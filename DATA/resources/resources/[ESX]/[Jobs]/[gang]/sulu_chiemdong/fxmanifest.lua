



fx_version 'bodacious'
games {'gta5'}

author 'sulu'
description 'sulu OCCUPATION'
version '1.0.3'

ui_page "ui/ui.html"
files {
	"ui/ui.html",
	"ui/imgs/*.png",
}
-- What to run
client_scripts {
    'config.lua',
    'lang.lua',
    'client.lua'
}
server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'lang.lua',
    'server.lua'
} 
shared_script {'@es_extended/imports.lua','@ox_lib/init.lua'}
lua54 'yes'
