






-- Resource Metadata
fx_version 'cerulean'
games { 'gta5' }

author 'sulu'
description 'Garage'
version '1.0.1'

-- What to run
client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua',
}
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}
dependencies {
	'es_extended',
}

ui_page('html/index.html') 
files({
	'html/index.html',
	'html/script.js',
	'html/style.css',
  })
lua54 'yes'
exports {
 'IsNearGarage',
}
shared_script {'@es_extended/imports.lua','@ox_lib/init.lua'}