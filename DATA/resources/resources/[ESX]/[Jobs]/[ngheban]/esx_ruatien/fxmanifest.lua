



server_scripts {
    '@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua'
}

fx_version 'adamant'

game {'gta5'}
dependencies {
	'es_extended'
}
shared_script '@es_extended/imports.lua'