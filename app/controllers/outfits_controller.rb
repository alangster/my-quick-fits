class OutfitsController < ApplicationController

  def index
  end

	def new
    temp = params[:temperature].to_i || session[:current_temp]
    precip = params[:precipitation].to_f || session[:chance_of_rain]
    @message_temp = make_temperature_statement(temp)
    @message_precip = "(#{make_precipitation_statement(precip)})"
		formal = 0
		clothes = Outfit.make_outfit(current_wardrobe, temp, precip > 0.5, formal)
		@tops = clothes[:tops]
		@bottom = clothes[:bottom]
		@shoes = clothes[:shoes]
		@outfit = Outfit.new
	end

	def create
    outfit = Outfit.create!(wardrobe: current_wardrobe)
    outfit.outfit_articles.create!(article_id: params[:bottom][:id])
    outfit.outfit_articles.create!(article_id: params[:shoes][:id])
    params[:top][:id].each do |id|
    	outfit.outfit_articles.create!(article_id: id)
    end
    redirect_to outfit
	end

	def show
		@outfit = Outfit.find(params[:id])
		@tops   = @outfit.tops
		@bottom = @outfit.bottom
		@shoes  = @outfit.shoes
    @count = @outfit.count_similar_outfits
    @fashion_quote, @fashion_quote_author = generate_fashion_quote
	end

  def formality
    p params[:temperature]
    temp = params[:temperature].to_i || session[:current_temp]
    precip = params[:precipitation].to_f || session[:chance_of_rain] > 0.5
    # params[:checked] == "true" ? formality = 1 : formality = 0
    clothes = Outfit.make_outfit(current_wardrobe, temp, precip, params[:formality].to_i)
    @tops = clothes[:tops]
    @bottom = clothes[:bottom]
    @shoes = clothes[:shoes]
    @outfit = Outfit.new
    return render partial: "new_outfit", layout: false
  end

  def custom_article
    article = Article.find(params[:id])
    render json: {id: article.id, name: article.category.name, type_of: article.category.type_of, primary_color_hex: article.primary_color_hex, icon: article.get_asset_icon_name}
  end

  def article_options
    article = Article.find(params[:id])
    category = article.category
    if category.type_of == "Top"
      articles = current_wardrobe.get_all_tops(category.layerable)
    else
      articles = current_wardrobe.get_articles_type_of(category.type_of)
    end
    options = { "articles" => [{id: article.id, name: article.category.name, type_of: article.category.type_of, primary_color_hex: article.primary_color_hex, icon: article.get_asset_icon_name}] }
    articles.each do |article|
      article_hash = {id: article.id, name: article.category.name, type_of: article.category.type_of, primary_color_hex: article.primary_color_hex, icon: article.get_asset_icon_name}
      if article.id != params[:id]
        options["articles"] << article_hash
      end
    end
    p options["articles"]
    render json: options, status: 200
  end

  def outfits_all
    options = {events: []}
    current_wardrobe.worn_outfits.each do |outfit|
      articles = outfit.tops + [outfit.bottom, outfit.shoes]
      title = "\n" + articles.map {|article| "#{article.primary_color} #{article.category.name}"}.join("\n")
      options[:events] << {
        title: title,
        start: outfit.created_at,
        url: outfit_path(outfit),
        outfit_id: outfit.id
      }
    end
    render json: options, status: 200
  end

  # def outfits_show
  #   options = {articles: [], message: params[:id]}
  #   outfit = Outfit.find(params[:id].to_i)
  #   outfit.articles.each do |article|
  #     options[:articles] << {
  #       name: "#{article.primary_color} #{article.category.name}"
  #     }
  #   end
  #   render json: options, status: 200
  # end

end
