



fx_version 'adamant'

game 'gta5'

ui_page 'html/index.html'

client_scripts {
    'client.lua',
    -- 'config.lua',
}

server_scripts {
    'server.lua',
    'config.lua',
}

files {
    'html/index.html',
    'html/style.css',
    'html/custom.js',
    'html/config.js',

    -- IMG
    'html/img/*.png',
    'html/*.png',

    --Audio
    'html/mohom.ogg',
}

shared_script '@es_extended/imports.lua'

lua54 'yes'