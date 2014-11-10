class ArticlesController < ApplicationController

	def new
		@article = Article.new
	end

	def show
		@article = Article.find(params[:id])
	end

	def color

		primary_color = RgbTriplet.new(params[:primary].map {|num| num.to_i})
		other_colors = []
		params[:other].each_value do |color| 
			other_colors << RgbTriplet.new(color.map {|num| num.to_i})			
		end

		secondary_color_hexes = other_colors.map { |color| color.to_hex }
		secondary_color_names = other_colors.map { |color| color.name }
		secondary_colors = secondary_color_hexes.zip(secondary_color_names)
		secondary_colors_array = []
		secondary_colors.each do |hex_name_pair|
			secondary_colors_array << { hex: hex_name_pair[0], name: hex_name_pair[1] }
		end

		response = { "primary" => { hex: primary_color.to_hex, name: primary_color.name },
			"other" => secondary_colors_array }

		render json: response, status: 200
		
	end

	def create
		article = Article.new(
			wardrobe:        current_wardrobe,
			# category:        params[:article][:category],
			pattern:         params[:article][:pattern],
			fabric:          params[:article][:fabric],
			formal?:         params[:article][:formal?] == "Business",
			water_proof?:    !params[:article][:water_proof].nil?,
			water_delicate?: !params[:article][:water_delicate].nil?,
			primary_color:   params[:primary][:name],
			primary_color_hex: params[:primary][:hex],
			secondary_color:   params[:other][:name][1],
			secondary_color_hex: params[:other][:hex][1],
			tertiary_color:   params[:other][:name][2],
			tertiary_color_hex: params[:other][:hex][2]
			)
		if article.save
			redirect_to article 
		else
			render "new"
		end
	end

	def destroy
		Article.find(params[:id]).destroy
		redirect_to current_wardrobe
	end

	def update
		@article = Article.find(params[:id])
		@article.update_attributes(article_update_params)
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

# {"utf8"=>"✓", 
#  "authenticity_token"=>"lOQgVHpirSfhznG6tUj+pc8GVtYB/GoItwlnf8rGXTA=", 
#  "article"=>{"category"=>"Bottom", 
#  						 "pattern"=>"polka-dot", 
#  						 "fabric"=>"tweed", 
#  						 "formal"=>"Business", 
#  						 "water_delicate"=>"water_delicate"}, 
#  	"primary"=>{"name"=>"Peru", "hex"=>"#bb884e"}, 
#  	"other"=>{"hex"=>["#c7965f", "#30221b", "#6b3613", "#a36316", "#795533", "#cdbfb4", "#e9c98b"], 
#  	         "name"=>["Peru", "Black", "Saddle Brown", "Sienna", "Saddle Brown", "Silver", "Burly Wood"]}, 
#  	"commit"=>"Create Article"}

