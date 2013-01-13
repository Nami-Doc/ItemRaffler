class Raffler.Views.Item extends Backbone.View
	template: JST'items/item'
	tag-name: 'li'

	# display
	# affichage
	render: ->
		$ @el .html @template {@model}
		this