


resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'


client_scripts {
  'functions.lua',
  'config.lua',


  'client.lua',


}



server_scripts {
  'config.lua',

  'server.lua',

}

dependencies {
	'es_extended',
	
}
shared_script {
	'@es_extended/imports.lua',
	'@ox_lib/init.lua'
}

lua54        'yes'
