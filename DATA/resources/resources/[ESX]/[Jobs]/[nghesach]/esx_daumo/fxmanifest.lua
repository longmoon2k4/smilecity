

fx_version 'adamant'
game 'gta5'

client_scripts {
    "client.lua",
    "config.lua",
}

server_scripts {
    "server.lua",
    "config.lua",
}

dependencies {
	'es_extended',
	
}
shared_script {
	'@es_extended/imports.lua',
	'@ox_lib/init.lua'
}

lua54        'yes'