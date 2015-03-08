Router.route(
    '/:language?/i18n-easy-admin/:section?'
    name: 'i18n_easy_admin'
    where: 'client'
    layoutTemplate: 'i18n_easy_layout'

    onBeforeAction: ->
        language = @params.language

        if language and I18nEasy.getLanguage() isnt language
            I18nEasy.setLanguage language

        unless I18nEasy.writeIsAllowed()
            do @stop
            @render 'i18n_easy_forbidden'

        do @next

    waitOn: ->
        options = {sections: [@route.getName()]}
        options.sections.push @params.section if @params.section
        I18nEasy.subscribeForTranslation options
)


Router.route(
    '/i18n-easy-translations'
    ->
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

        @response.end JSON.stringify(translations)

    name: 'i18n_easy_translations'
    where: 'server'
)
