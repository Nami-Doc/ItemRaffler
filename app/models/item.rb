class Item < ActiveRecord::Base
	#ensure we have a name
	#assurons-nous d'avoir l'attribut "name"
	validates :name, presence: true
end
