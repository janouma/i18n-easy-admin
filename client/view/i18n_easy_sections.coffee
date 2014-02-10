templateName = 'i18n_easy_sections'

Template[templateName].helpers {
	sections: -> do I18nEasy.getSections
	section: -> Router.current().params.section
	newSection: -> Router.current().params.section?.length and Router.current().params.section not in I18nEasy.getSections()
	clazz: (section)->
		if section is Router.current().params.section
			'theme-magenta color-bloodywhite'
		else
			'theme-ash color-lightmagenta'
}

Template[templateName].events {
	'input #newSection': (e)->
		$addButton = $('#addSection')

		if /^\w+$/.test $(e.target).val().trim()
			$addButton.addClass('color-magenta').removeClass('disabled color-silver')
		else
			$addButton.addClass('disabled color-silver').removeClass('color-magenta')

	#==================================
	'click #addSection:not(.disabled)': ->
		$newSectionInput = $('#newSection')
		section = $.trim $newSectionInput.val()
		Router.go 'i18n_easy_admin', section: section
		Alert.success 'addOneKeyAtLeast'
}