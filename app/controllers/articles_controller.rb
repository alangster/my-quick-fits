class ArticlesController < ApplicationController

	def new
		@article = Article.new
	end

	def show
		@article = Article.find(params[:id])
	end

	def create
		primary_color_name, primary_color_hex = article_color_data(params[:primary])
		secondary_color_name, secondary_color_hex = article_color_data(params[:secondary])
		tertiary_color_name, tertiary_color_hex = article_color_data(params[:tertiary])
		article = Article.new(
			wardrobe:        current_wardrobe,
			category_id:        params[:category],
			primary_color:   primary_color_name,
			primary_color_hex: primary_color_hex,
			secondary_color:   secondary_color_name,
			secondary_color_hex: secondary_color_hex,
			tertiary_color:   tertiary_color_name,
			tertiary_color_hex: tertiary_color_hex,
			times_worn: 0
			)
		if article.save
			flash[:notice] = "#{article.category.name} added successfully!"
			redirect_to current_user
		else
			@article = Article.new
			render "new"
		end
	end

	def destroy
		Article.find(params[:id]).destroy
		redirect_to current_wardrobe
	end

	def update
		p params
		# creater RgbTriplet objects using hex, find name
		@article = Article.find(params[:id])
		@article.primary_color_hex   = params["primary-hex"] unless params["primary-hex"] == ""
		@article.primary_color       = color_name(@article.primary_color_hex) #params["primary-name"] unless params["primary-name"] == ""
		@article.secondary_color_hex = params["secondary-hex"] unless params["secondary-hex"] == ""
		@article.secondary_color     = color_name(@article.secondary_color_hex) #params["secondary-name"] unless params["secondary-name"] == ""
		@article.tertiary_color_hex  = params["tertiary-hex"] unless params["tertiary-hex"] == ""
		@article.tertiary_color      = color_name(@article.tertiary_color_hex) #params["tertiary-name"] unless params["tertiary-name"] == ""
		@article.condition           = params[:article][:condition] #unless params[:article][:condition].blank?

		if @article.save
			redirect_to @article
		else
			@message = @article.errors.first
			render "show"

		end
	end

	private

	def article_update_params
		# For right now, I'll slot in the ones in the form, but we'll need to decide on these
		params.require(:article).permit(:pattern, :times_worn, :condition)
	end

end


