



fx_version 'adamant'
games { 'gta5' }

client_scripts {
	'client/main.lua',
	'client/shells.lua',
	'client/furnished.lua',
}
 
files {
	'stream/playerhouse_hotel/playerhouse_hotel.ytyp',
	'stream/playerhouse_tier1/playerhouse_tier1.ytyp',
	'stream/playerhouse_tier3/playerhouse_tier3.ytyp',
}

data_file 'DLC_ITYP_REQUEST' 'stream/v_int_20.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/playerhouse_hotel/playerhouse_hotel.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/playerhouse_tier1/playerhouse_tier1.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/playerhouse_tier3/playerhouse_tier3.ytyp'

exports {
	'DespawnInterior',
	'CreateMotel',
	'CreateTier1House',
	'CreateTier2House',
	'CreateTier3House',

	'CreateTier1HouseFurnished',
}










