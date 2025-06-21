



--[[ fxmanifest ]]

fx_version 'adamant'

game {'gta5'}

author 'Sulu'

description 'lam ban?'

version '1.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/vn.lua',
	'config.lua',
	'server/main.lua',
	'server/coke.lua',
	'server/meth.lua',
	'server/weed.lua',
	--'server/sanho.lua',
	'server/heroin.lua',
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/vn.lua',
	'config.lua',
	'client/main.lua',
	'client/weed.lua',
	'client/meth.lua',
	'client/coke.lua',
	--'client/sanho.lua',
	'client/heroin.lua',
	-- 'client/hydrochloricacid.lua',
}

dependencies {
	'es_extended'
}
lua54 'yes'
shared_script {'@es_extended/imports.lua','@ox_lib/init.lua'}