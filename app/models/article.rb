class Article < ActiveRecord::Base
	belongs_to :wardrobe
	belongs_to :category
	has_many :outfit_articles
	has_many :outfits, through: :outfit_articles
	# has_one :type, through: :category

  NEUTRALS = ["Black", "White", "Grey", "Brown", "Navy", "Beige", "Bisque", "Blanched Almond", "Burly Wood", "Chocolate", "Cornsilk", "Dark Goldenrod", "Dark Gray", "Dark Khaki", "Dim Gray","Floral White", "Gainsboro", "Ghost White","Gray", "Honeydew", "Indigo", "Light Gray", "Slate Gray", "Midnight Blue", "Moccasin", "Navajo White", "Peru", "Saddle Brown", "Sienna", "Snow", "Tan", "Wheat", "White Smoke"]


  def count_in_outfits
    count = 0
    Outfit.all.each do |outfit|
      count += 1 if outfit.articles.include? self
    end
    count
  end

  def good_condition?
    self.condition == nil
  end

  def clean?
    # find most recent outfit that included item, check if older than 7 days
    self.times_worn == 0
  end

  def within_temp?(temperature)
    # needs to change
    self.category.min_temp <= temperature && self.category.max_temp >= temperature
  end

  def water_resistant?
    !self.water_delicate?
  end

  def proper_dress_code?(formal)
    # formal = formal == 0 ? false : true
    self.category.formality == formal
  end

  def is_neutral?
    NEUTRALS.include?(self.primary_color)
  end

  def complementary?(other_articles)
    complementary_colors?(self, other_articles) && complementary_styles?(self, other_articles)
  end

  def complementary_colors?(article, other_articles)
    if other_articles.all? { |article| article.is_neutral? }
      return true
    else
      article.is_neutral?
    end
  end

  def complementary_styles?(article1, other_articles)
    true
  end

  def self.get_appropriate_articles(articles, temperature, precipitation, formal, other_articles=nil)
    new_articles = articles.dup
    possibilities = new_articles
    results = { articles: new_articles,
                complementary: true,
                proper_dress_code: true,
                water_resistant: true,
                good_condition: true,
                clean: true,
                within_temp: true }

    possibilities = new_articles.select { |article| article.good_condition? }
    possibilities.length != 0 ? new_articles = possibilities : results[:good_condition] = false

    if temperature
      possibilities = new_articles.select { |article| article.within_temp?(temperature) }
      possibilities.length != 0 ? new_articles = possibilities : results[:within_temp] = false
    end

    if other_articles
      possibilities = new_articles.select { |article| article.complementary?(other_articles) }
      possibilities.length != 0 ? new_articles = possibilities : results[:complementary] = false
    end

    possibilities = new_articles.select { |article| article.proper_dress_code?(formal) }
    possibilities.length != 0 ? new_articles = possibilities : results[:proper_dress_code] = false

    if precipitation
      possibilities = new_articles.select { |article| article.water_resistant? }
      possibilities.length != 0 ? new_articles = possibilities : results[:water_resistant] = false
    end

    possibilities = new_articles.select { |article| article.clean? }
    possibilities.length != 0 ? new_articles = possibilities : results[:clean] = false

    results[:articles] = new_articles
    results
  end

  def get_icon_name
    self.category.name.gsub(" ", "-") + ".png"
  end

  def get_asset_icon_name
    ActionController::Base.helpers.asset_path(self.get_icon_name)
  end

end
