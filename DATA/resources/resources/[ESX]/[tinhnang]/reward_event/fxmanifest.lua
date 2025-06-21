

fx_version 'adamant'

game 'gta5'

description ''
name ' '

version '1.0'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'share/*.lua',
    'server/*.lua',

}   

client_scripts {
    'share/*.lua',
    'client/*.lua',
}



ui_page "html/index.html"

files {
    "html/index.html",
    "html/style.css",
	"html/script.js",

	"html/imgs/*.png",
    "html/imgs/*.jpg"
}
shared_script {'@ox_lib/init.lua','@es_extended/imports.lua'}

 lua54 'yes'
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 