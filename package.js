Package.describe({
	summary: "Admin ui for i18n-easy"
});

Package.on_use(function(api, where){
	api.use(['coffeescript', 'minimongo', 'mongo-livedata', 'iron-router']);
	//api.use(['templating', 'handlebars', 'font-awesome'], 'client');
	api.use(['templating', 'ui', 'font-awesome'], 'client');

	var clientFiles = [];

	clientFiles.push('i18n_easy_router.coffee');
	clientFiles.push('client/helpers/alert.coffee');
	clientFiles.push('client/view/i18n_easy_side_nav.html');
	clientFiles.push('client/view/i18n_easy_side_nav.coffee');
	clientFiles.push('client/view/i18n_easy_nav.html');
	clientFiles.push('client/view/i18n_easy_nav.coffee');
	clientFiles.push('client/view/i18n_easy_header.html');
	clientFiles.push('client/view/i18n_easy_footer.html');
	clientFiles.push('client/view/i18n_easy_layout.html');
	clientFiles.push('client/view/i18n_easy_layout.coffee');
	clientFiles.push('client/view/i18n_easy_translation.html');
	clientFiles.push('client/view/i18n_easy_translation.coffee');
	clientFiles.push('client/view/i18n_easy_sections.html');
	clientFiles.push('client/view/i18n_easy_sections.coffee');
	clientFiles.push('client/view/i18n_easy_admin.html');
	clientFiles.push('client/view/i18n_easy_admin.coffee');
	clientFiles.push('client/view/i18n_easy_forbidden.html');
	clientFiles.push('client/stylesheets/style.css');
	clientFiles.push('client/stylesheets/build-full-no-icons.min.css');

	api.add_files(clientFiles, 'client');
	api.add_files(['server/i18n_easy_init.coffee', 'i18n_easy_router.coffee'], 'server');
});