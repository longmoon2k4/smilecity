

fx_version 'adamant'
game 'gta5'

description 'Sulu'

version '1.4.2'

server_scripts {
    'config.lua',
	'server/main.lua'
}

client_scripts {
	'config.lua',
	'client/main.lua'
}

dependencies {
	'es_extended',
	
}
shared_script {
	'@es_extended/imports.lua',
	'@ox_lib/init.lua'
}
lua54        'yes'
