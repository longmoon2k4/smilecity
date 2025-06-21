



fx_version 'cerulean'
games { 'gta5' }

author 'Sulu'
description 'Sulu'
version '1.0.0'

-- What to run

client_scripts {
    'client/*.lua',
}

server_scripts{
    '@mysql-async/lib/MySQL.lua',
    'server/*.lua',
} 

dependencies {
	'es_extended'
}
shared_scripts {
    "config.lua",
    '@es_extended/imports.lua',
    '@ox_lib/init.lua'
}

lua54 'yes'