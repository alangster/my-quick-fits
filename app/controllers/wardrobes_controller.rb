class WardrobesController < ApplicationController

	def show
		@bottoms = current_wardrobe.get_all_bottoms 
		@tops = current_wardrobe.get_articles_type_of("Top") 
		@shoes = current_wardrobe.get_all_shoes 
	end

	def analysis
 		@missing_categories = Category.find_missing(current_wardrobe)
    @favorite_categories = item_counts(current_wardrobe.articles.map {|article| article.category}).first(3)
 		@damaged = current_wardrobe.damaged
 		@avg_count = Article.all.count / User.all.count
    @tops_percent = calculate_percent(current_wardrobe.get_articles_type_of("Top").count, current_wardrobe.articles.count)
    @avg_tops = Article.all.select {|article| article.category.type_of == "Top"}.count / User.all.count
    @bottoms_percent = calculate_percent(current_wardrobe.get_articles_type_of("Bottom").count, current_wardrobe.articles.count)
    @avg_bottoms = Article.all.select {|article| article.category.type_of == "Bottom"}.count / User.all.count
    @shoes_percent = calculate_percent(current_wardrobe.get_articles_type_of("Shoes").count, current_wardrobe.articles.count)
    @avg_shoes = Article.all.select {|article| article.category.type_of == "Shoes"}.count / User.all.count

    @fav_colors = item_percents(current_wardrobe.articles.map {|article| article.primary_color}, current_wardrobe.articles.count).first(3)
    @least_categories = item_counts(current_wardrobe.articles.map {|article| article.category}).last(3)
    @least_fav_colors = item_percents(current_wardrobe.articles.map {|article| article.primary_color}, current_wardrobe.articles.count).last(3)
 	end

  def wardrobe_categories
    options = { "categories" => [] }
    categories = Category.where(type_of: params[:id])
    categories.each do |category|
      category_hash = {id: category.id, name: category.name, type_of: category.type_of, icon: category.get_asset_icon_name}
      options["categories"] << category_hash
    end
    render json: options, status: 200
  end

  def custom_category
    category = Category.find(params[:id])
    render json: {id: category.id, name: category.name, type_of: category.type_of, icon: category.get_asset_icon_name}
  end

end
