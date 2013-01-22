Raffler.Views.Item = Backbone.View.extend do
	template: JST'items/item'
	tagName: 'li'

	#display
	#affichage
	render: ->
		$ @el .html @template {@model}
		this