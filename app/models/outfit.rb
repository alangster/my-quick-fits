class Outfit < ActiveRecord::Base
	belongs_to :wardrobe
	has_many	 :outfit_articles
	has_many	 :articles, through: :outfit_articles


  def get_articles_type_of(type_of)
    self.articles.select { |article| article.category.type_of == type_of }.sort_by { |a| a.category.name }
  end

  def get_all_tops(layerable)
    self.get_articles_type_of("Top").select {|top| top.category.layerable == layerable}
  end

  def tops
    self.get_articles_type_of("Top")
  end

  def bottom
    self.get_articles_type_of("Bottom")[0]
  end

  def shoes
    self.get_articles_type_of("Shoes")[0]
  end

  def count_similar_outfits
    count = 0
    Outfit.all.each do |outfit|
      count += 1 if self.articles == outfit.articles && outfit.like == 0
    end
    count
  end

  def self.get_worn_outfits(wardrobe)
    wardrobe.outfits
  end

  def self.outfit_error_messages(results)
    s = []
    s << "Had trouble finding matching clothes!" if !results[:complementary]
    s << "Had trouble finding clothes with proper dress code!" if !results[:proper_dress_code]
    s << "Had trouble finding water-resistant clothes!" if !results[:water_resistant]
    s << "Had trouble finding clothes in good condition!" if !results[:good_condition]
    s << "Had trouble finding clean clothes!" if !results[:clean]
    # s << "Had trouble finding clothes for the weather!" if !results[:within_temp]
    s
  end

  def self.make_outfit(current_wardrobe, temperature, precipitation, formal)

    outfit_so_far = []
    errors = []

    tops = []
    current_layer = 0
    while current_layer < 4 do
      tops_current_layer = current_wardrobe.get_all_tops(current_layer)
      results = Article.get_appropriate_articles(tops_current_layer, temperature, precipitation, formal, outfit_so_far)
      tops << results[:articles].sample
      break if results[:within_temp]
      current_layer += 1
      outfit_so_far << tops.last
      errors += outfit_error_messages(results)
    end

    bottoms = current_wardrobe.get_all_bottoms
    results = Article.get_appropriate_articles(bottoms, temperature, precipitation, formal, outfit_so_far)
    bottom_final = results[:articles].sample
    errors += outfit_error_messages(results)
    outfit_so_far << bottom_final

    shoes = current_wardrobe.get_all_shoes
    results = Article.get_appropriate_articles(shoes, temperature, precipitation, formal, outfit_so_far)
    shoes_final = results[:articles].sample
    errors += outfit_error_messages(results)

    {tops: tops, bottom: bottom_final, shoes: shoes_final, errors: errors.uniq}
  end
end
