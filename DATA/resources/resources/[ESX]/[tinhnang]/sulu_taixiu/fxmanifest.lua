


fx_version 'cerulean'
games { 'gta5' }

description 'Tai xiu'

version '1.0.0'

client_script {'client/main.lua',}
server_script {'server/main.lua',}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/app.js',
	'html/style.css',
	'html/imgs/dice.png',
	'html/imgs/img.png',
	'html/imgs/roll1.gif',
	'html/imgs/den.png',
	'html/imgs/trang.png',
}
shared_script {'@es_extended/imports.lua'}