



fx_version 'adamant'

game 'gta5'
client_scripts {
	'config.lua',
	'client.lua'
}

server_scripts {
	'config.lua',
	'server.lua'
}


dependencies {
	'es_extended',
	
}
shared_script '@es_extended/imports.lua'




server_scripts { '@mysql-async/lib/MySQL.lua' }