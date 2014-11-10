class Wardrobe < ActiveRecord::Base
	belongs_to :user
	has_many :outfits
	has_many :articles

  NEUTRALS = ["green", "orange"] # CHANGE THIS

  def get_articles_type_of(type_of)
    self.articles.select { |article| article.category.type_of == type_of }.sort_by { |a| a.category.name }
  end

  def get_all_tops(layerable)
    self.get_articles_type_of("Top").select {|top| top.category.layerable == layerable}
  end

  def get_all_bottoms
    self.get_articles_type_of("Bottom")
  end

  def get_all_shoes
    self.get_articles_type_of("Shoes")
  end

  def color_percentages
     colors = self.articles.pluck(:primary_color).uniq

    wardrobe_count = self.articles.count
    color_percentages_hash(colors.map {|color| { "#{color}" => (self.articles.where(primary_color: color).count / wardrobe_count.to_f) * 100 }})
  end

  def color_percentages_hash(color_arr)
    percent_hash = { neutrals: [], colors: [] }
    color_arr.each do |color_hash|
      if NEUTRALS.include?(color_hash.keys[0])
        percent_hash[:neutrals] << color_hash
      else
        percent_hash[:colors] << color_hash
      end
    end
    percent_hash
   end
 
   def damaged
    self.articles.where.not(condition: nil)
   end
 
 end