templateName = 'i18n_easy_sections'

check = (val)-> /^\w+$/.test val

submit = -> # TODO check input first
	$newSectionInput = $('#newSection')
	section = $.trim $newSectionInput.val()
	Router.go 'i18n_easy_admin', section: section
	Alert.warning 'addOneKeyAtLeast'

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

		if check $(e.target).val().trim()
			$addButton.addClass('color-magenta').removeClass('disabled color-silver')
		else
			$addButton.addClass('disabled color-silver').removeClass('color-magenta')

	#==================================
	'keypress #newSection': (e)-> do submit if (e.key is 'enter' or e.keyCode is 13) and check $(e.target).val().trim()

	#==================================
	'click #addSection:not(.disabled)': -> do submit
}