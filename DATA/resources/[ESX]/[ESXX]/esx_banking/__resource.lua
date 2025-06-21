



resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page('client/html/UI.html')

server_scripts {  
	'locale.lua',
	'locales/en.lua',
	'config.lua',
	'server.lua'
}


client_scripts {
	'locale.lua',
	'locales/en.lua', 
	'config.lua',
	'client/client.lua'
}

export 'openUI'

files {
	'client/html/UI.html',
    'client/html/style.css',
    'client/html/media/font/Bariol_Regular.otf',
    'client/html/media/font/Vision-Black.otf',
    'client/html/media/font/Vision-Bold.otf',
    'client/html/media/font/Vision-Heavy.otf',
    'client/html/media/img/bg.png',
    'client/html/media/img/circle.png',
    'client/html/media/img/curve.png',
    'client/html/media/img/fingerprint.png',
    'client/html/media/img/fingerprint.jpg',
    'client/html/media/img/graph.png',
    'client/html/media/img/logo-big.png',
    'client/html/media/img/logo-top.png',
    'locale.js',
}

shared_script '@es_extended/imports.lua'

dependencies {
	'es_extended',
}server_scripts { '@mysql-async/lib/MySQL.lua' }