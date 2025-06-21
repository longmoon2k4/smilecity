



--	esx-qalle-jail
--		2018
--		Carl "Qalle"
--		2018
--	esx-qalle-jail

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description "Jail Script With Working Job"

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"config.lua",
	"server/server.lua"
}

client_scripts {
	
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/EntityZone.lua',
	'@PolyZone/CircleZone.lua',
	'@PolyZone/ComboZone.lua',
	"config.lua",
	"client/utils.lua",
	"client/client.lua",
}

dependencies {
	'es_extended',
	
}
lua54 'yes'
shared_script {'@es_extended/imports.lua', '@ox_lib/init.lua'}