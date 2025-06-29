




fx_version 'cerulean'
game 'gta5'

author 'Legendary45'
version '1.0.0'

ui_page 'html/index.html'

client_scripts {
    'Config.lua',
    'Client/*.lua'
}

server_scripts{
    '@mysql-async/lib/MySQL.lua',
    'Config.lua',
    'Server/*.lua'
}

files {
    'html/index.html',
    'html/css/*.css',
    'html/*.css',
    'html/js/*.js',
    'html/js/*.js.map',
    'html/img/*.png',
    'html/img/*.jpg',
    'html/img/*.gif',
    -- 'html/_sounds/*.mp3',
}

shared_script {
	'@es_extended/imports.lua'
}