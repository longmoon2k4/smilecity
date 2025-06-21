



fx_version 'cerulean'
games { 'gta5' }

author 'Sulu'
description 'Sulu'
version '1.0.0'

-- What to run
--client_script "config.lua"
client_scripts {
    'client.lua',
}
server_scripts{
    'server.lua',
} 

dependencies {
	'es_extended'
}
shared_script '@es_extended/imports.lua'