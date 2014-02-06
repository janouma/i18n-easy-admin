Router.map ->
	@route(
		'i18n_easy_admin'
		where: 'client'
		path: '/:language?/i18n-easy-admin/:section?'
		layoutTemplate: 'i18n_easy_layout'

		before: ->
			language = @params.language

			if language and I18nEasy.getLanguage() isnt language
				I18nEasy.setLanguage language

			unless I18nEasy.writeIsAllowed()
				do @stop
				@render 'i18n_easy_forbidden'


		waitOn: ->
			options = {sections: [@params.section]} if @params.section
			I18nEasy.subscribeForTranslation options
	)

	@route(
		'i18n_easy_translations'
		where: 'server'
		path: '/i18n-easy-translations'
		action: ->
			@response.writeHead 200, 'Content-Type': 'application/json; charset=utf-8'

			translations = {}
			I18nEasyMessages.find(
				{}
				sort:
					language: 1
					section: 1
					key: 1
			).forEach (document)->
				if document.language?.length and document.key?.length and document.message?.length
					language = translations[document.language] ?= {}
					if document.section?.length
						section = language[document.section] ?= {}
						section[document.key] = document.message
					else
						language[document.key] = document.message

			@response.write JSON.stringify(translations)
			do @response.end
	)