class Raffler.Routers.Items extends Backbone.Router
	routes:
		'':			\index
		'items':	\index
		'items/:id': \show

	initialize: !->
		@collection = new Raffler.Collections.Items
		
		# will triggers event "reset"
		# lancera l'évènement "reset"
			..fetch!

	index: !->
		view = new Raffler.Views.ItemsIndex {@collection}
		
		#fill the container
		#remplissage du conteneur
		$ '#container' .html view.render!el

	show: !->
		alert "Showing item #it"