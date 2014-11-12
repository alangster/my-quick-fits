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
 			damaged_items:     current_wardrobe.damaged
 		}
 	end

  def wardrobe_categories
    # category = Category.find(params[:id])
    # category = article.category
    options = { "categories" => [] }
    categories = Category.where(type_of: params[:id])
    categories.each do |category|
      category_hash = {id: category.id, name: category.name, type_of: category.type_of, icon: category.icon_name}
      options["categories"] << category_hash
    end
    render json: options, status: 200
  end

  def custom_category
    category = Category.find(params[:id])
    render json: {id: category.id, name: category.name, type_of: category.type_of, icon: category.icon_name}
  end

end
