



fx_version 'cerulean'
games { 'gta5' }

author 'Sulu'
description 'Sulu'
version '1.0.0'

client_scripts {
    'client.lua',
}
server_scripts{
    'server.lua',
    '@mysql-async/lib/MySQL.lua',
} 

dependencies {
	'es_extended'
}
shared_script '@es_extended/imports.lua'