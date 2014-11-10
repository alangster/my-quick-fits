class Outfit < ActiveRecord::Base
	belongs_to :wardrobe
	has_many	 :outfit_articles
	has_many	 :articles, through: :outfit_articles

  def self.make_outfit(current_wardrobe, temperature, precipitation, formal)
    bottoms = current_wardrobe.get_all_bottoms
    results = Article.get_appropriate_articles(bottoms, temperature, precipitation, formal)
    bottom_final = results[:articles].sample

    tops = []
    current_layer = 0
    while current_layer < 4 do 
      tops_current_layer = current_wardrobe.get_all_tops(current_layer)
      results = Article.get_appropriate_articles(tops_current_layer, temperature, precipitation, formal, bottom_final)
      tops << results[:articles].sample
      break if results[:within_temp]
      current_layer += 1
    end

    shoes = current_wardrobe.get_all_shoes
    results = Article.get_appropriate_articles(shoes, temperature, precipitation, formal, bottom_final)
    shoes_final = results[:articles].sample

    {tops: tops, bottom: bottom_final, shoes: shoes_final}
  end
end
