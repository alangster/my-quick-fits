class OutfitsController < ApplicationController
  def index
  end

	def new
    temp = params[:temperature].to_i || session[:current_temp]
    precip = params[:precipitation].to_f || session[:chance_of_rain]
    @message_temp = make_temperature_statement(temp)
    @message_precip = "(#{make_precipitation_statement(precip)})"
		formal = 0
		results = Outfit.make_outfit(current_wardrobe, temp, precip > 0.5, formal)
		@tops = results[:tops]
    @top_names = results[:top_names]
		@bottom = results[:bottom]
    @bottom_name = results[:bottom_name]
    @shoes = results[:shoes]
		@shoes_name = results[:shoes_name]
    @outfit_issues = render_error_message(results)
    rain_jacket = current_wardrobe.articles.where(category: Category.find_by(name: "Rain Jacket"))[0]
    if precip > 0.5 && rain_jacket && temp <= rain_jacket.category.max_temp
      if @tops.last.category.layerable < 3
        @tops << rain_jacket
      else
        @tops[-1] = rain_jacket
      end
    end
    if @tops.any?(&:nil?) || @bottom.nil? || @shoes.nil?
      flash[:notice] = "You don't have enough in your wardrobe to make an outfit!"
      redirect_to current_user
    else
		  @outfit = Outfit.new
    end
	end

	def create
    outfit = create_outfit_record(params)
    outfit.articles.each {|article| article.increment!(:times_worn)}
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
    temp = params[:temperature].to_i || session[:current_temp]
    precip = params[:precipitation].to_f || session[:chance_of_rain] > 0.5
    results = Outfit.make_outfit(current_wardrobe, temp, precip, params[:formality].to_i)
    @tops = results[:tops]
    @top_names = results[:top_names]
    @bottom = results[:bottom]
    @bottom_name = results[:bottom_name]
    @shoes = results[:shoes]
    @shoes_name = results[:shoes_name]
    @outfit_issues = render_error_message(results)
    @outfit = Outfit.new
    return render partial: "new_outfit", layout: false
  end

  def custom_article
    article = Article.find(params[:id])
    render json: {id: article.id, name: article.category.name, type_of: article.category.type_of, color: article.render_gradient, icon: article.get_asset_icon_name}
  end

  def article_options
    article = Article.find(params[:id])
    category = article.category
    if category.type_of == "Top"
      articles = current_wardrobe.get_all_tops(category.layerable)
    else
      articles = current_wardrobe.get_articles_type_of(category.type_of)
    end
    options = { "articles" => [{id: article.id, name: article.category.name, type_of: article.category.type_of, color: article.render_gradient, icon: article.get_asset_icon_name}] }
    articles.each do |article|
      article_hash = {id: article.id, name: article.category.name, type_of: article.category.type_of, color: article.render_gradient, icon: article.get_asset_icon_name}
      if article.id != params[:id]
        options["articles"] << article_hash
      end
    end
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

  def outfits_like
    outfit = create_outfit_record(params)
    outfit.update_attributes(like: 1)
    render json: {}, status: 200
  end

  def outfits_dislike
    outfit = create_outfit_record(params)
    outfit.update_attributes(like: -1)
    render json: {}, status: 200
  end

  private

  def create_outfit_record(params)
    outfit = Outfit.create!(wardrobe: current_wardrobe)
    outfit.outfit_articles.create!(article_id: params[:bottom][:id])
    outfit.outfit_articles.create!(article_id: params[:shoes][:id])
    params[:top][:id].each do |id|
      outfit.outfit_articles.create!(article_id: id)
    end
    outfit
  end

  def render_error_message(results)
    msg = results[:errors].join(" ")
    msg = "* " + msg if msg.strip() != ""
    msg
  end
end
