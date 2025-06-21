



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
    'server/*.lua',
} 

dependencies {
	'es_extended'
}
shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua'
}

lua54 'yes'