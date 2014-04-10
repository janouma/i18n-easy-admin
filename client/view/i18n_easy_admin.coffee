templateName = 'i18n_easy_admin'

checkKey = (val)-> val?.length and /^\w+$/.test val

submitKey = ->
	$newKeyInput = $('#newKey')

	Alert.info 'processing'

	newKeyValue = $newKeyInput.val().trim()
	parameters = [newKeyValue]
	parameters.push(Router.current().params.section) if Router.current().params.section

	Meteor.call(
		'i18nEasyAddKey'
		parameters...
		(error)->
			if error
				Alert.error(if error.error is 409 then 'duplicatedKey' else 'internalServerError')
			else
				$newKeyInput.val ''
				Alert.success 'successful'
	)


statusClasses =
	info: 'theme-sky color-black'
	success: 'theme-emerald color-black'
	warning: 'theme-gold color-black'
	error: 'theme-redlight color-black'


Template[templateName].helpers {
	submitMessage: -> Alert.message()
	submitMessageVisibility: -> 'hidden' unless Alert.message()
	submitMessageStatus: ->
		status = Alert.status()
		statusClasses[status] if status

	translations: -> I18nEasy.translations(Router.current().params.section)
}


Template[templateName].events {

	'submit form': (e)->
		do e.preventDefault

		translations = []

		if Router.current().params.section
			addSectionIfAny = (document)->
				document.section = Router.current().params.section
				document
		else
			addSectionIfAny = (document)-> document

		$('[id^=translation_]').each ->
			$singular = $(@).find '[name=singular]'
			singularValue = $.trim $singular.val()
			singularInitialValue = $singular.attr('data-initial-value') or ''

			$plural = $(@).find '[name=plural]'
			pluralValue = $.trim $plural.val()
			pluralInitialValue = $plural.attr('data-initial-value') or ''

			if singularValue isnt singularInitialValue or pluralValue isnt pluralInitialValue
				message = if pluralValue?.length then [singularValue, pluralValue] else singularValue

			if message
				translations.push(
					addSectionIfAny {
						key: $(@).attr 'data-key'
						language: I18nEasy.getLanguage()
						message: message
					}
				)

		if translations.length
			Alert.info 'processing'

			Meteor.call(
				'i18nEasySave'
				translations
				(error)->
					if error
						Alert.error 'internalServerError'
					else
						Alert.success 'successful'

			)
		else Alert.warning 'nothingToSave'

	#==================================
	'click #add:not(.disabled)': (e)->
		do e.preventDefault
		do submitKey if checkKey $('#newKey').val().trim()

	#==================================
	'input #newKey': (e)->
		$addButton = $('#add')

		if checkKey $(e.target).val().trim()
			$addButton.addClass('color-magenta').removeClass('disabled color-silver')
		else
			$addButton.addClass('disabled color-silver').removeClass('color-magenta')

	#==================================
	'keypress #newKey': (e)->
		if (e.key is 'enter' or e.keyCode is 13)
			do e.preventDefault
			do submitKey if checkKey $(e.target).val().trim()
}