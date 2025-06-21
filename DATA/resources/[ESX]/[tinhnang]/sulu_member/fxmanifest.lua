



fx_version 'cerulean'
games { 'gta5' }

author 'DeathNote'
description 'bo_mmember'
version '1.0.0'

client_scripts {
  "client/main.lua",
}
server_scripts {
  "server/main.lua",
  "@async/async.lua",
	"@mysql-async/lib/MySQL.lua",
}

ui_page "html/ui.html"

files {
    "html/*.html",
    "html/css/style.css",
    "html/css/ui.css",
    "html/js/*.js",
    "html/img/*.png",
    "html/img/*.jpg",
  }

dependency 'es_extended'
shared_script '@es_extended/imports.lua'