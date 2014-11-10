class WardrobesController < ApplicationController

	def show
		@bottoms = current_wardrobe.get_all_bottoms #current_wardrobe.articles.select { |article| article.category.type_of == "Bottom" }
		@tops = current_wardrobe.get_articles_type_of("Top") #current_wardrobe.articles.select { |article| article.category.type_of == "Top" }
		@shoes = current_wardrobe.get_all_shoes #current_wardrobe.articles.select { |article| article.category.type_of == "Shoes" }
	end

	def analysis
 		@missing_categories = Category.find_missing(current_wardrobe)
 		@stats = {
 			color_percentages: current_wardrobe.color_percentages,
 			damaged_items:     current_wardrobe.damaged,
 			wears:             {
 													most: current_wardrobe.most_worn,
 													least: current_wardrobe.least_worn
 													} 
 		}
 	end

end
