



fx_version 'cerulean'
games { 'gta5' }

client_script 'client.lua'

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
    'server.lua'
}
dependencies {
	'es_extended',
	
}
shared_script '@es_extended/imports.lua'