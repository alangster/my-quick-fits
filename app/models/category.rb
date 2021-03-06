class Category < ActiveRecord::Base
	belongs_to :type
	has_many :articles

	include IconNameHelper

	NECESSITIES = ["T-Shirt", "Polo Shirt", "Button Down Shirt", "Dress Shirt", "Blazer", "Down Jacket", "Rain Jacket", "Dress Pants", "Jeans", "Chino Shorts", "Dress Shoes", "Sneakers"]

	def self.find_missing(wardrobe)
		find_missing_names(wardrobe).map {|name| Category.find_by(name:name)}
	end

	def self.find_missing_names(wardrobe)
		NECESSITIES - wardrobe.articles.map {|article| article.category.name}.uniq
	end

	def month_wears(current_wardrobe)
		count = 0
		current_wardrobe.outfits.each do |outfit|
			if outfit.like != 1 && outfit.like != -1
				outfit.articles.each do |article|
					count += 1 if article.category == self && true 
				end
			end
		end
		count
	end

	def fav_color(wardrobe)
		wardrobe.articles.where(category: self) 
	end

	def get_icon_name
		icon_name(self.name, "#FFFFFF")
	end

	def get_asset_icon_name
		asset_icon_name(self.name, "#FFFFFF")
	end

	private

	def item_counts_hash(ary)
	  seen = Hash.new(0)
	  ary.each {|value| seen[value] += 1}
	  seen
	end

	def item_counts(ary)
		item_counts_hash(ary).sort_by {|k,v| -v}
	end

end
