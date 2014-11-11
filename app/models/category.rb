class Category < ActiveRecord::Base
	belongs_to :type
	has_many :articles

  validates :type_of, presence: true


	NECESSITIES = ["T-Shirt", "Polo Shirt", "Button Down Shirt", "Dress Shirt", "Blazer", "Down Jacket", "Rain Jacket", "Dress Pants", "Jeans", "Chino Shorts", "Dress Shoes", "Sneakers"]

	def icon_name
		ActionController::Base.helpers.asset_path(self.icon_name_format)
	end

	def icon_name_format
		self.name.gsub(" ", "-") + ".png"
	end

	def self.find_missing(wardrobe)
		find_missing_names(wardrobe).map {|name| Category.find_by(name:name)}
	end

	def self.find_missing_names(wardrobe)
		NECESSITIES - wardrobe.articles.map {|article| article.category.name}.uniq
	end

end
