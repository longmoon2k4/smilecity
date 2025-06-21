

fx_version 'cerulean'
games {'gta5'}
lua54 'yes'
this_is_a_map 'yes'

files {
    'stream/ntl_baucua.ytyp',
    'html/index.html',
    'html/*.css',
    'html/*.js',
    'html/img/*.png',
    'html/img/*.jpg',
}

data_file 'DLC_ITYP_REQUEST' 'stream/ntl_baucua.ytyp'


ui_page 'html/index.html'

client_scripts {
    "client/*.lua"
}

shared_script {'config.lua','@es_extended/imports.lua','@ox_lib/init.lua'}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}

escrow_ignore {
    'config.lua'
}
