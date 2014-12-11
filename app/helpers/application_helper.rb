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
    session[:current_temp] = forecast.currently.temperature
    session[:max_temp] = forecast.daily.data[0].temperatureMax
    session[:min_temp] = forecast.daily.data[0].temperatureMin
    session[:chance_of_rain] = forecast.daily.data[0].precipProbability
    session[:summary] = forecast.daily.data[0].summary
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

  def dark?(rgb_arr)
    rgb.all? {|val| val <= 50 }
  end

  def calculate_percent(top_number, total)
    (top_number / total.to_f * 100).to_i
  end

  def item_counts_hash(ary)
    seen = Hash.new(0)
    ary.each {|value| seen[value] += 1}
    seen
  end

  def item_counts(ary)
    item_counts_hash(ary).sort_by {|k,v| -v}
  end

  def mode(ary)
    seen = item_counts_hash(ary)
    max = seen.values.max
    seen.find_all {|key,value| value == max}[0] 
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

end

