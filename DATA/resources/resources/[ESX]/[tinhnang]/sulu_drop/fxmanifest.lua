

fx_version 'adamant'
games { 'gta5' }

client_scripts {
	'config.lua',
	'function.lua',
	'main.lua'
}

server_scripts {
	'config.lua',
	'server/function.lua',
	'server/main.lua'
}

shared_script {'@ox_lib/init.lua','@es_extended/imports.lua'}

lua54 'yes'