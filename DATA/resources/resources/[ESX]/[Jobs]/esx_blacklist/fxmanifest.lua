



fx_version 'bodacious'
games {'gta5'}

author 'Sulu'
description 'black list'
version '1.0.3'

description 'REQUEST'
ui_page "html/index.html"
files {
	"html/index.html",
	"html/*.js",
	"html/index.css",
}
client_scripts {
	'client/main.lua',
    'client/**/*.lua'
}
server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
    'server/**/*.lua'
}

dependencies {
	'mysql-async'
}

shared_script '@es_extended/imports.lua'
--
--