Meteor.startup ->

	I18nEasy.mapAll {
		en:
			translationAdmin: "translation manager"

			i18n_easy_admin:
				add: "add"
				cancel: "cancel"
				default: "default"
				delete: "delete"
				download: "download"
				duplicatedKey: "the key already exists"
				duplicatedLanguage: "the language already exists"

				internalServerError:[
					"an error occurred server side"
					"several errors occurred server side"
				]

				newKey: "new key"
				newLanguage: "new language"
				nothingToSave: "there is nothing worth saving"
				plural: "plural"
				processing: "processing ..."
				save: "save"
				singular: "singular"
				successful: "everything went well"

				unknownError: [
					"an unknown error occurred"
					"several unknown errors occured"
				]

				upload: "upload"
				wrongFileType: "wrong file type"
				resourceForbidden: "access forbidden"
				resourceForbiddenBody: "you are not allowed to access this resource"
				noSection: "no section"
				addOneKeyAtLeast: "one key at least is required"
				newSection: "new section"

		fr:
			en: "english"
			fr: "français"
			translationAdmin: "gestionnaire des traductions"

			i18n_easy_admin:
				add: "ajouter"
				cancel: "annuler"
				default: "défaut"
				delete: "supprimer"
				download: "télécharger"
				duplicatedKey: "la clé existe déjà"
				duplicatedLanguage: "la langue existe déjà"
				export: "export"
				import: "import"
				internalServerError: "une erreur est survenue côté serveur"
				newKey: "nouvelle clé"
				newLanguage: "nouvelle langue"
				nothingToSave: "rien ne vaut la peine d'être enregistré"
				plural: "pluriel"

				processing:[
					"traitement en cours ..."
					"traitements en cours ..."
				]

				save: "enregistrer"
				singular: "singulier"
				successful: "tout s'est bien passé"

				unknownError:[
					"une erreur inconnue est survenue"
					"plusieurs erreurs inconnues sont survenues"
				]

				upload: "envoyer"
				wrongFileType: "le fichier n'est pas du type attendu"
				resourceForbidden: "accès non-autorisé"
				resourceForbiddenBody: "vous n'êtes pas autorisé à accéder à cette ressource"
				noSection: "aucune section"
				addOneKeyAtLeast: "une clé au moins est requise"
				newSection: "nouvelle section"
	}