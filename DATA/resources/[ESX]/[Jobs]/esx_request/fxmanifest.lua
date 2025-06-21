



fx_version 'bodacious'
games {'gta5'}

author 'sulu'
version '1.0.3'

description 'REQUEST'
ui_page "html/index.html"
files {
	"html/index.html",
	"html/*.js",
	"html/index.css",
	"html/money.mp3"
}
client_scripts {
	'config.lua',
	'client/main.lua',
    'client/**/*.lua'
}
server_scripts {
	'config.lua',
	'server/main.lua',
    'server/**/*.lua'
}

shared_script '@es_extended/imports.lua'
--
--