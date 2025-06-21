


-- Resource Metadata
fx_version 'bodacious'
games { 'gta5' }

author 'rubbertoe98'
description 'CarryPeople'
version '1.0.0'

client_script "cl_carry.lua"
server_script "sv_carry.lua"

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    '@es_extended/imports.lua',
}


dependencies {
    'ox_target'
}