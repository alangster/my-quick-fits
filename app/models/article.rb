class Article < ActiveRecord::Base
	belongs_to :wardrobe
	belongs_to :category
	has_many :outfit_articles
	has_many :outfits, through: :outfit_articles
  validates :category_id, :primary_color, presence: true

  include IconNameHelper

  NEUTRALS = ["Black", "White", "Grey", "Brown", "Navy", "Beige", "Bisque", "Blanched Almond", "Burly Wood", "Chocolate", "Cornsilk", "Dark Goldenrod", "Dark Gray", "Dark Khaki", "Dim Gray","Floral White", "Gainsboro", "Ghost White","Gray", "Honeydew", "Light Gray", "Slate Gray", "Midnight Blue", "Moccasin", "Navajo White", "Peru", "Saddle Brown", "Sienna", "Snow", "Tan", "Wheat", "White Smoke"]

  NO_NOS = {
    "Dress Pants"     => ["Sneakers", "TOMs", "Flip-Flops", "Sandals", "T-Shirt", "Tanktop", "Long-Sleeve T-Shirt", "Crewneack, Sweatshirt", "Hooded Pullover Sweatshirt", "Full-Zip Hooded Sweatshirt"],
    "Jeans"           => ["Dress Shoes"],
    "Chino Pants"     => ["Flip-Flops"],
    "Corduroy Pants"  => ["Tanktop", "Dress Shoes", "Flip-Flops", "Sandals"],
    "Cargo Pants"     => ["Dress Shirt", "Blazer", "Dress Shoes"],
    "Sweatpants"      => ["Polo Shirt", "Button Down Shirt", "Dress Shirt", "Cardigan", "Crewneck Sweater", "Half-Zip Sweater", "Blazer", "Peacoat", "Dress Shoes", "Desert Boots", "Penny Loafers"],
    "Chino Shorts"    => ["Dress Shirt", "Dress Shoes", "Desert Boots"],
    "Athletic Shorts" => ["Polo Shirt", "Button Down Shirt", "Dress Shirt", "Cardigan", "Crewneck Sweater", "Half-Zip Sweater", "Blazer", "Peacoat", "Dress Shoes", "Desert Boots", "Penny Loafers"],
    "Cargo Shorts"    => ["Polo Shirt", "Button Down Shirt", "Dress Shirt", "Cardigan", "Crewneck Sweater", "Half-Zip Sweater", "Blazer", "Peacoat", "Dress Shoes", "Desert Boots", "Penny Loafers"],
    "Jean Shorts"     => ["Polo Shirt", "Button Down Shirt", "Dress Shirt", "Cardigan", "Crewneck Sweater", "Half-Zip Sweater", "Blazer", "Peacoat", "Dress Shoes", "Desert Boots", "Penny Loafers"]
  }

  def count_in_outfits
    count = 0
    Outfit.all.each do |outfit|
      count += 1 if outfit.articles.include? self
    end
    count
  end

  def good_condition?
    self.condition.nil?
  end

  def clean?
    # find most recent outfit that included item, check if older than 7 days
    # ignore shoes, jeans, jackets
    # self.times_worn == 0
    true
  end

  def within_temp?(temperature)
    self.category.min_temp <= temperature && self.category.max_temp >= temperature
  end

  def water_resistant?
    return true if self.water_proof?
    !self.water_delicate? 
  end

  def proper_dress_code?(formal)
    self.category.formality == formal
  end

  def is_neutral?
    NEUTRALS.include?(self.primary_color) 
  end

  def complementary?(other_articles)
    self.complementary_colors?(other_articles) 
  end

  def complementary_colors?(other_articles)
    if other_articles.all? { |a| a.is_neutral? }
      true
    else
      self.is_neutral?
    end
  end

  def complementary_styles?(article, other_articles)
    true
  end

  def self.get_appropriate_articles(articles, temperature, precipitation, formal, other_articles=[])
    new_articles = articles.dup
    possibilities = new_articles
    results = { complementary: true,
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

    if other_articles.length > 0
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

  def render_gradient
    primary = self.primary_color_hex
    secondary = (self.secondary_color_hex.nil? ? primary : self.secondary_color_hex)
    tertiary = (self.tertiary_color_hex.nil? ? secondary : self.tertiary_color_hex)
    "background: linear-gradient(#{primary} 50%,#{secondary} 50%,#{tertiary})"
  end

  def get_icon_name
    icon_name(self.category.name, self.primary_color_hex)
  end

  def get_asset_icon_name
    asset_icon_name(self.category.name, self.primary_color_hex)
  end

  def descriptive_condition
    return "Fresh" if self.condition.nil?
    self.condition.strip() == '' ? "Fresh" : self.condition
  end

  def most_recent_wear
    wear_dates = self.outfits.pluck(:created_at)
    if wear_dates == []
      false
    else
      "The last time you wore this was #{wear_dates.last.strftime("%B %d, %Y")}."
    end
  end

end
