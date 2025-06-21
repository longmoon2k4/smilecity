



--[[ fxmanifest ]]

fx_version 'adamant'

game {'gta5'}

author 'Phaos ¦ soahP#9050'

description 'Np Menu'

version '1.0.0'

client_script {
    "config.lua",
	"client_menu.lua",
	"emotes_triggers.lua"
}

ui_page "html/ui.html"

files {
	"html/ui.html",
	"html/css/RadialMenu.css",
	"html/js/RadialMenu.js",
	'html/css/all.min.css',
	'html/js/all.min.js',
	
}

dependency 'es_extended'
shared_script '@es_extended/imports.lua'