



fx_version 'adamant'

game {'gta5'}
client_scripts {
	"@es_extended/locale.lua",
    "clienten.lua",
	
}

server_scripts {
	"server.lua",
	'@es_extended/locale.lua',
	'@mysql-async/lib/MySQL.lua'
	
}


dependencies {
    "es_extended"
}
shared_script '@es_extended/imports.lua'
