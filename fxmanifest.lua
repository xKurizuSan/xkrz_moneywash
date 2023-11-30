fx_version "cerulean"
game "gta5"
author "xKurizu"
description "Money Wash Script for ESX"
version "1.0.0"

shared_scripts {
	'@ox_lib/init.lua',
	'@es_extended/imports.lua'  
}

client_script {
	'config.lua',
	"client.lua",
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/CircleZone.lua'
}
server_script {
	"config.lua",
	"server.lua"
}
  
lua54 'yes'