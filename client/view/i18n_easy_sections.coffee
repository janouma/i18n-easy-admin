Template.i18n_easy_sections.helpers {
	sections: -> do I18nEasy.getSections
	section: -> Router.current().params.section
	newSection: -> Router.current().params.section not in I18nEasy.getSections()
	clazz: (section)->
		if section is Router.current().params.section
			'theme-magenta color-bloodywhite'
		else
			'theme-ash color-lightmagenta'
}