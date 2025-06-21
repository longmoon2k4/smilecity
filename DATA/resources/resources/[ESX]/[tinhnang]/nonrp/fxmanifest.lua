


fx_version 'adamant'

game {'gta5'}

ui_page 'html/ui.html'

client_scripts{
    "config.lua",
    "client.lua",
} 

server_scripts{
    "config.lua",
    "server.lua",
} 

files {
	'html/ui.html',
	'html/style.css',
	'html/grid.css',
	'html/main.js',
}

shared_script {'@es_extended/imports.lua','@ox_lib/init.lua'}
lua54 'yes'