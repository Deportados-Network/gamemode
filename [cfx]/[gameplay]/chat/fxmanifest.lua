description 'chat management stuff'

ui_page 'html/index.html'

client_script 'cl_chat.lu*'
server_script 'sv_chat.lu*'

files {
	'html/*.html',
	'html/*.css',
	'html/*.default.js',
	'html/*.js',
	'html/vendor/vue.2.3.3.min.js',
	'html/vendor/flexboxgrid.6.3.1.min.css',
	'html/vendor/animate.3.5.2.min.css',
	'html/vendor/*.css',
	'html/vendor/fonts/*.woff2',
}

fx_version 'adamant'
games { 'rdr3', 'gta5' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
client_script '@Interpol/Shareds/ToLoad.lua'