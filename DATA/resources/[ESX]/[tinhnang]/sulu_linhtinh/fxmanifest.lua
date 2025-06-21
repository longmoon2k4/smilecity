



fx_version 'adamant'

game {'gta5'}

version '1.0.0'

client_scripts {
	'client/config.lua',
	'client/lenmatdat.lua',
}

client_scripts {
--'thayquanao.lua',
 'damesung.lua',
'blacklist.lua',
'config.lua',
--'teleport.lua',
}



dependency 'es_extended'

shared_scripts {
  '@es_extended/imports.lua',
  '@ox_lib/init.lua'
}

lua54 'yes'
