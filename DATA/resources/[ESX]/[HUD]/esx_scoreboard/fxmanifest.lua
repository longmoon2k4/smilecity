



fx_version 'adamant'

game 'gta5'

description 'ESX Scoreboard'

version '1.0.0'

server_script {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua',
}

client_script 'client/main.lua'

ui_page 'html/scoreboard.html'

files {
	'html/scoreboard.html',
	'html/style.css',
	'html/listener.js'
}

dependencies {
	'es_extended',
	
}
shared_script '@es_extended/imports.lua'