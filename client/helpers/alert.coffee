collection = new Meteor.Collection null

toast = null

send = (status, key)->
	Meteor.clearTimeout toast

	collection.remove {}
	currentMessageId = collection.insert {
		status: status
		message: I18nEasy.i18nDefault key
		path: Router.current().path
	}

	toast = Meteor.setTimeout(
		=> collection.remove _id: currentMessageId
		5000
	)

module =
	message: -> collection.findOne()?.message
	status: -> collection.findOne()?.status
	path: -> collection.findOne()?.path


statuses = [
	'success'
	'info'
	'warning'
	'error'
]

for status in statuses
	do (status)->
		module[status] = (key)-> send(status, key)
		module["is#{status[0].toUpperCase()}#{status[1..]}"] = -> collection.findOne()?.status is status


@Alert = module