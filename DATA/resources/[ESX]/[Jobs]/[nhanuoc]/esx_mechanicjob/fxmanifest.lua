



fx_version 'adamant'

game 'gta5'

description 'ESX Mechanic Job'

version '1.1.0'

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/es.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/br.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'locales/nl.lua',
	'config.lua',
	'client/main.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/es.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/br.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'locales/nl.lua',
	'config.lua',
	'server/main.lua'
}

dependencies {
	'es_extended',
	'/onesync',

}
shared_script {'@es_extended/imports.lua', '@ox_lib/init.lua'}
lua54        'yes'
