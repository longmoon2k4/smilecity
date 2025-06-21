

fx_version 'cerulean'
games { 'gta5' }

author 'sulu'
description 'giam xe'
version '1.0.0'

-- What to run
client_scripts {
    'config.lua',
    'client/*.lua'
}

server_scripts{
    "@mysql-async/lib/MySQL.lua",
    'config.lua',
    'server/*.lua'
}
ui_page "html/index.html"

files{
    "html/index.html",
    "html/*.png",
    "html/*.js",
    "html/*.css",
}

dependencies {
	'es_extended',
	
}
shared_script '@es_extended/imports.lua'

server_scripts { '@mysql-async/lib/MySQL.lua' }