



fx_version 'adamant'

game {'gta5'}

author 'Phaos ¦ soahP#9050'

description 'ESX Accessories'

version '1.0.0'

server_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/es.lua',
	'locales/ru.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'locales/cs.lua',
	'locales/pl.lua',
	'locales/vi.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/es.lua',
	'locales/ru.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'locales/cs.lua',
	'locales/pl.lua',
	'locales/vi.lua',
	'config.lua',
	'client/main.lua'
}

dependencies {
	'es_extended',
	-- 'esx_skin',
	-- 'esx_datastore',
	-- 'esx_np_skinshop_v2'
}

shared_script '@es_extended/imports.lua'server_scripts { '@mysql-async/lib/MySQL.lua' }