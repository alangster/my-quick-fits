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
    s
  end

  def self.has_error?(results)
    flag = results[:complementary] &&
           results[:proper_dress_code] &&
           results[:water_resistant] &&
           results[:good_condition] &&
           results[:clean]
    !flag
  end

  def self.get_modified_name(article, results)
    return "" if article.nil?
    name = article.category.name
    name += " *" if has_error?(results)
    name
  end

  def self.make_outfit(current_wardrobe, temperature, precipitation, formal)

    outfit_so_far = []
    errors = []

    tops = []
    top_names = []
    current_layer = 0
    while current_layer < 4 do
      tops_current_layer = current_wardrobe.get_all_tops(current_layer)
      results = Article.get_appropriate_articles(tops_current_layer, temperature, precipitation, formal, outfit_so_far)
      chosen_top = results[:articles].sample
      tops << chosen_top
      top_names << get_modified_name(tops.last, results)
      break if results[:within_temp] && !current_wardrobe.any_other_formal_tops?(chosen_top)
      current_layer += 1
      outfit_so_far << tops.last
      errors += outfit_error_messages(results)
    end

    bottoms = current_wardrobe.get_all_bottoms


    results = Article.get_appropriate_articles(bottoms, temperature, precipitation, formal, outfit_so_far)
    bottom_final = results[:articles].sample
    bottom_name = get_modified_name(bottom_final, results)
    errors += outfit_error_messages(results)
    outfit_so_far << bottom_final

    shoes = current_wardrobe.get_all_shoes

    results = Article.get_appropriate_articles(shoes, temperature, precipitation, formal, outfit_so_far)
    shoes_final = results[:articles].sample
    shoes_name = get_modified_name(shoes_final, results)
    errors += outfit_error_messages(results)

    {tops: tops, top_names: top_names, bottom: bottom_final, bottom_name: bottom_name, shoes: shoes_final, shoes_name: shoes_name, errors: errors.uniq}
  end
end
