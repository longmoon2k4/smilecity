

fx_version 'cerulean'
games {'gta5'}

ui_page 'html/ui.html'

client_script {
    'client.lua'
}

server_script {
    '@async/async.lua',
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}

files {
	'html/ui.html',
	'html/style.css',
	'html/grid.css',
	'html/main.js',
	'html/img/*.png',
	'html/img/*.gif'
}


dependencies {
    "es_extended"
}

shared_script '@es_extended/imports.lua'


lua54 'yes'





