

fx_version 'adamant'

game 'gta5'

server_scripts {
	'@es_extended/locale.lua',
	'locales/cs.lua',
	'locales/en.lua',
	'locales/es.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/cs.lua',
	'locales/en.lua',
	'locales/es.lua',
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