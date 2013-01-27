#XXX: mv items_index.js.ls => index.js.ls ?
Raffler.Views.ItemsIndex = Backbone.View.extend do
	template: JST'items/index'

	events:
		'submit #new_item': 'addItem'
		'click #remove': 'deleteItem'

	initialize: !->
		#reset when fetch(), remove when destroy()
		#reset appelé via fetch(), remove appelé via destroy()
		@collection.on 'reset remove' @render
		@collection.on 'add' @appendItem

	render: ~>
		$ @el .html @template
		#for each element, call "appendItem"
		#pour chaque element, on appelle "appendItem"
		@collection.each @append-item
		this


	add-item: ->
		#DOM caching
		$name = $ '#new_item_name'

		#attributes list - only the name
		#liste des attributs - uniquement le nom
		attributes =
			name: $name.val!
		
		#@collection.create triggers a HTTP request
		#@collection.create fait une requête HTTP
		item = @collection.create attributes,
			#wait for the server's answer before triggering the event
			#on attend la réponse serveur avant de lancer l'évènement "add"
			wait: true
			
			#if it worked, clear the field
			#si ça a marché, on vide le champ
			success: !-> $name.val ''
			
			#else handle errors
			#sinon on s'occupe des erreurs - plus bas
			error: @handle-error
		false
	
	#triggered when clicking on [x]
	#quand on clique sur [x]
	delete-item: ({current-target}) ->
		#element
		target = $ current-target
		
		#data-id=""
		item = @collection.get target.data 'id'
		
		#destroy the element, and triggers the event "remove"
		#supprime l'élèment, et lance l'évènement "remove"
		item.destroy!
		
		#don't follow the link
		#ne pas suivre le lien
		false

	#button "Add"
	#bouton "add"
	append-item: !(model) ~>
		#create a view for that model
		#on créé une vue pour ce model
		view = new Raffler.Views.Item {model}
		
		#and add it to the item list (ul#items)
		#et on l'ajoute à la liste des items(<ul id="items")
		$ '#items' .append view.render!el


	#handle errors
	#gestion des erreurs
	handle-error: !(, {status, response-text}) ->
		#code 422 : bad request
		#code 422 : requête incorrecte
		if status is 422
			#get the error, using jQuery.parseJSON on response.responseText
			#on récupère les erreurs, en utilisant jQuery.parseJSON sur response.responseText
			errors = $.parse-JSON response-text .errors
			
			# {'name' => ['is blank']}
			# {'name' => ['est blanc']}
			for attribute, messages in errors
				#alert errors for each attribute
				#pour chaque attribut, on affiche les erreurs
				alert "#attribute: #{messages * ', '}."
