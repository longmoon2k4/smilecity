



fx_version 'adamant'

game 'gta5'

description 'ESX Holdup'

version '1.1.0'


client_scripts {
	'@es_extended/locale.lua',
	'locales/br.lua',
	'config.lua',
	'client/main.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'locales/br.lua',
	'config.lua',
	'server/main.lua'
}

dependencies {
	'es_extended',
	
}
shared_script '@es_extended/imports.lua'




