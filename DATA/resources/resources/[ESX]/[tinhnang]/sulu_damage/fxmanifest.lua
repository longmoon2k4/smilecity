


fx_version 'cerulean'
games { 'gta5' }

version '1.0.0'


client_scripts {
'damage.lua',
}

ui_page "ui.html"

files {
    "ui.html",
    "img/die.png",
    "img/hit.ogg"
}
server_scripts{
    'server.lua'
}
shared_scripts {
  '@es_extended/imports.lua',
  '@ox_lib/init.lua'
}

lua54 'yes'
