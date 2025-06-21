






-- Resource Metadata
fx_version 'cerulean'
games { 'gta5' }

author 'Sulu'
description 'Key car'
version '1.0.1'

-- What to run
client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'client.lua',
}
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server.lua'
}
dependencies {
	'es_extended',
}
exports {
    "checkPlate",
 }
lua54 'yes'

shared_script {'@es_extended/imports.lua','@ox_lib/init.lua'}