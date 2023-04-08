fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

name 'woro-drugs'
author 'WoroWoro#3229'
version '1.0.0'

shared_script {
    '@es_extended/imports.lua',
}

server_scripts {
    'config.lua',
    'server/main.lua'
}

client_scripts {
    'client/actionkey.lua',
    'client/main.lua',
}

dependencies {
    'es_extended',
    'PolyZone',
}