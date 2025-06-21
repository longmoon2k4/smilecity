



resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

files {
'data/**/peds.meta'
}

client_script {
	'config.lua',
    'client.lua'
}

server_script {
    '@async/async.lua',
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server.lua'
}


dependencies {
    "es_extended"
}
shared_script '@es_extended/imports.lua'
data_file 'PED_METADATA_FILE' 'data/**/peds.meta'