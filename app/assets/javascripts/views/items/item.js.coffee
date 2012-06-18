class Raffler.Views.Item extends Backbone.View
	template: JST['items/item']
	tagName: 'li'

	#display
	#affichage
	render: =>
		$(@el).html @template(item: @model)
		this