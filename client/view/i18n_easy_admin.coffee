templateName = 'i18n_easy_admin'

Template[templateName].helpers {
	submitMessage: -> Alert.message()
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

			$plural = $(@).find '[name=plural]'
			pluralValue = $.trim $plural.val()

			if singularValue isnt $singular.attr('data-initial-value') or pluralValue isnt $plural.attr('data-initial-value')
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

		$newKeyInput = $('#newKey')

		Alert.info 'processing'

		Meteor.call(
			'i18nEasyAddKey'
			$.trim $newKeyInput.val()
			(error)->
				if error
					Alert.error(if error.error is 409 then 'duplicatedKey' else 'internalServerError')
				else
					Alert.success 'successful'
		)

	#==================================
	'input #newKey': (e)->
		$addButton = $('#add')

		if /^\w+$/.test $(e.target).val().trim()
			$addButton.addClass('color-magenta').removeClass('disabled color-silver')
		else
			$addButton.addClass('disabled color-silver').removeClass('color-magenta')
}


Template[templateName].rendered = ->
	return unless Alert.changed

	Meteor.clearTimeout @_toast
	$messageElts = $('#submit-result, #submit-note')

	showMessage = =>
		statusClasses =
			info: 'theme-sky color-black'
			success: 'theme-emerald color-black'
			warning: 'theme-gold color-black'
			error: 'theme-redlight color-black'

		if Alert.status()
			$messageElts.addClass(statusClasses[Alert.status()])
				.removeClass 'hidden'

		$('#add').addClass('disabled color-silver').removeClass('color-magenta')

		$('#newKey').val('') if Alert.isSuccess()

	if Alert.path() is Router.current().path
		Meteor.defer showMessage
	else
		showMessage()

	@_toast = Meteor.setTimeout(
		=>
			do Alert.clear
			$messageElts.addClass 'hidden'
		5000
	)