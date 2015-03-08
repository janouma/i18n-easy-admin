templateName = 'i18nEasySections'

check = (val)-> val?.length and /^\w+$/.test val

submit = ->
	$newSectionInput = $('#newSection')
	section = $.trim $newSectionInput.val()
	Router.go Router.current().route.getName(), section: section
	Alert.warning 'addOneKeyAtLeast'

Template[templateName].helpers {
	sections: -> do I18nEasy.getSections
	section: -> Router.current().params.section
	newSection: -> check(Router.current().params.section) and Router.current().params.section not in I18nEasy.getSections()
	default: -> @toString() is Router.current().route.getName()
	clazz: (section)->
		if section is Router.current().params.section
			'active theme-magenta color-bloodywhite'
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

	#==================================
	'click .delete': (e, template)->
		do e.preventDefault

		Meteor.clearTimeout template._toast
		$ask = $(template.find '.ask')
		$delete = $(e.target)
		$link = $delete.parents('a')
		offset = $link.offset()

		$ask.offset(
			top: offset.top + $delete.height() - 5
			left: offset.left + $link.width()/2 - $ask.width()/2 + 20
		).removeClass('hidden').addClass('visible')

		template._targetedSection = $delete.attr('data-section')
		template._cancel = no

		template._toast = Meteor.setTimeout(
			->
				template._targetedSection = undefined
				template._cancel = yes
				$ask.addClass('hidden').removeClass('visible')
			5000
		)

	#==================================
	'click .cancel': (e, template)->
		do e.preventDefault

		template._targetedSection = undefined
		template._cancel = yes
		Meteor.clearTimeout template._toast
		$(template.find('.ask')).addClass('hidden').removeClass('visible')

	#==================================
	'click .confirm': (e, template)->
		do e.preventDefault
		return if template._cancel

		$(template.find '.ask').addClass('hidden').removeClass('visible')

		if template._targetedSection
			Meteor.call(
				'i18nEasyRemoveSection'
				template._targetedSection

				(error)->
					if error
						Alert.error 'internalServerError'
					else
						Alert.success 'successful'
						Router.go(Router.current().route.getName()) if template._targetedSection is Router.current().params.section
						template._targetedSection = undefined
			)
}
