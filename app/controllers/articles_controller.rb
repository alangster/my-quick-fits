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
			redirect_to article
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
		primary_color_name = (params["primary-hex"] == "" ?  : )
		@article = Article.find(params[:id])
		@article.update_attributes(
			primary_color: color_name(params["primary-hex"]),
			primary_color_hex: params["primary-hex"],
			secondary_color: color_name(params["secondary-hex"]),
			secondary_color_hex: params["secondary-hex"],
			tertiary_color: color_name(params["tertiary-hex"]),
			tertiary_color_hex: params["tertiary_color_hex"]
			)
		if @article.save
			redirect_to current_wardrobe
		else
			render "show"
		end
	end

	private

	def article_update_params
		# For right now, I'll slot in the ones in the form, but we'll need to decide on these
		params.require(:article).permit(:pattern, :times_worn, :condition)
	end

end


