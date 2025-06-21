

fx_version 'adamant'
game 'gta5'

description 'ESX langbam Job'

version '1.2.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua',
	'client/job.lua'
}

dependencies {
	'es_extended',
	'd3x_vehicleshop'
}

shared_script {
	'@es_extended/imports.lua',
	'@ox_lib/init.lua'
}

lua54        'yes'
--
--