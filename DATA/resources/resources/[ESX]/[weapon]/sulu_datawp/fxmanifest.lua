fx_version 'cerulean'
games { 'gta5' }

author 'KMS'
description 'Data Weapon'
version '1.0.0'
files {
	'weapons.meta',
	'weaponcomponents.meta',
	'weaponanimations.meta',
	'data/**/weapon_meta/*.meta',
	'data/**/weaponcomponetns.meta',
	'data/**/weaponanimations.meta'
}
 
data_file 'WEAPONINFO_FILE_PATCH' 'weapons.meta'
data_file 'WEAPONINFO_FILE_PATCH' 'data/**/weapon_meta/*.meta'
data_file 'WEAPONCOMPONENTSINFO_FILE' 'weaponcomponents.meta'
data_file 'WEAPONCOMPONENTSINFO_FILE' 'data/**/weaponcomponents.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'weaponanimations.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'data/**/weaponanimations.meta'