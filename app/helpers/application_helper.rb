module ApplicationHelper

	def current_user
		User.find_by(id: session[:user_id])
	end

	def current_wardrobe
		current_user.wardrobes.first if current_user
	end

  def daily_forecast
    ForecastIO.api_key = '521aad1331e6f66d7bf1ed4ec06b9aa3'
    forecast = ForecastIO.forecast(session[:latitude], session[:longitude])
    daily = forecast.daily.data[0]
    session[:current_temp] = forecast.currently.temperature
    session[:max_temp] = daily.temperatureMax
    session[:min_temp] = daily.temperatureMin
    session[:chance_of_rain] = daily.precipProbability
    session[:summary] = daily.summary
  end

  def make_temperature_statement(temp)
    case 
    when temp < 20 then "Why do you live in Chicago...? It's stupid-cold out! Wear everything"
    when temp < 40 then "It's colder than Matt Baker's general disposition, put on more than a white tee!"
    when temp < 60 then "Brisk, chilly, cool, nippy, crisp, whatever... the point is, today is 'jacket weather'"
    when temp < 80 then "You wait all year for days like today. Put on your fresh fits and get out there!"
    else
      "Thermostat setting: Hell. Enjoy :)"
    end
  end

  def make_precipitation_statement(precip)
    case 
    when precip <= 0.05 then "And it's definitely not going to rain today. Great success!"
    when precip < 0.3   then "And there's a slight chance of rain but I wouldn't worry too much"
    when precip < 0.5   then "And it's probably going to rain today. You have galoshes...? Didn't think so"
    else
      "And it's raining. No really, look outside"
    end
  end

  def generate_fashion_quote
    [
      ["Fashion is never finished",  "Fake Mark Zuckerberg"],
      ["If you look good, you feel good. If you feel good, you play good. If you play good, they pay good", "Deion Sanders"],
      ["What fun is it being cool if you can't wear a sombrero?",  "Bill Watterson"],
      ["Sweatpants are a sign of defeat. You lost control of your life so you bought some sweatpants.",  "Karl Lagerfeld"],
      ["Looking good isn’t self-importance; it’s self-respect.",  "Charles Hix"],
      ["If I think about it too much, I can’t get dressed.",  "Daphne Guinness"],
      ["Do I make fashion mistakes? Yes, but I won’t say what.",  "Domenico Dolce"]
    ].sample
  end

  def rgb_parse(rgb_str)
    rgb_str.split(',').map {|r| r.to_i}
  end

  def article_color_data(rgb_str)
    name = nil
    hex = nil
    if rgb_str != ""
      color = RgbTriplet.new(rgb_parse(rgb_str))
      name = color.name
      hex = color.to_hex
    end
    [name, hex]
  end

  def color_name(hex)
    hex.nil? ? nil : RgbTriplet.new(to_rgb(hex)).name
  end

  def to_rgb(hex)
    hex.delete('#').scan(/\S{2}/).map(&:hex)
  end

  def calculate_percent(top_number, total)
    (top_number / total.to_f * 100).to_i
  end

  def item_counts_hash(ary)
    ary.group_by {|item| item}
  end

  def item_counts(ary)
    pair_array = item_counts_hash(ary).sort_by {|k,v| -v.count}
    pair_array.map {|pair| [pair[0], pair[1].count]}
  end

  def last_wear(category)
    dates = []
    Outfit.get_worn_outfits(current_wardrobe).each do |outfit|
      outfit.articles.each do |article|
        if article.category == category
          dates << outfit.created_at
        end
      end
    end
    return dates.length != 0 ? dates.sort.last : "never"
  end

  def item_percents(ary, total)
    item_counts(ary).map {|item, count| [item, calculate_percent(count,total)]}
  end

  def dark?(hex)
    rgb = to_rgb(hex)
    brightness = Math.sqrt( 0.241 * (rgb[0]**2) + 0.691 * (rgb[1]**2) + 0.068 * (rgb[2]**2))
    brightness <= 130
  end

  def icon_name(name, hex)
    if dark?(hex)
      name.gsub(" ", "-") + "-W.png"
    else
      name.gsub(" ", "-") + ".png"
    end
  end

  def asset_icon_name(name, hex)
    ActionController::Base.helpers.asset_path(icon_name(name, hex))
  end

end

