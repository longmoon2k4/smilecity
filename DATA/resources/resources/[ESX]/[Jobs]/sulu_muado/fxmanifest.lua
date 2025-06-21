,'@ox_lib/init.lua'}



fx_version 'adamant'
game 'gta5'

description 'Sulu'

version '1.2.0'

client_scripts {
  "config.lua",
  "client.lua"
}

server_scripts {
  "config.lua",
  "server.lua"
}

dependencies {
	'es_extended',
	
}
shared_script {'@es_extended/imports.lua','@ox_lib/init.lua'}

lua54 'yes'