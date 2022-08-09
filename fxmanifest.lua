fx_version 'cerulean'

game 'gta5'

description 'QB Drive School'

version '1.0.0'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/*.lua',
    'config.lua',
}

client_script 'client/main.lua'

server_scripts {	
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

ui_page 'html/ui.html'

files {
	'html/ui.html',
	'html/logo.png',
	'html/dmv.png',
	'html/styles.css',
	'html/questions.js',
	'html/scripts.js',
	'html/debounce.min.js'
}

lua54 'yes'