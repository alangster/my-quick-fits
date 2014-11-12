module ApplicationHelper

	def current_user
		User.find_by(id: session[:user_id])
	end

	def current_wardrobe
		current_user.wardrobes.first if current_user
	end

  def daily_forecast
    ForecastIO.api_key = '521aad1331e6f66d7bf1ed4ec06b9aa3'
    current_weather = ForecastIO.forecast(41.87, -87.62)
  end

  def current_temp
    ForecastIO.api_key = '521aad1331e6f66d7bf1ed4ec06b9aa3'
    current_weather = ForecastIO.forecast(41.87, -87.62)
    temperature = current_weather.currently.temperature
    # return (temperature.round.to_s) + " °F"
    temperature
  end

  def max_temp
    ForecastIO.api_key = '521aad1331e6f66d7bf1ed4ec06b9aa3'
    current_weather = ForecastIO.forecast(41.87, -87.62)
    max_temp = current_weather.daily.data[0].temperatureMax
    # return (max_temp.round.to_s) + " °F"
    max_temp
  end

  def min_temp
    ForecastIO.api_key = '521aad1331e6f66d7bf1ed4ec06b9aa3'
    current_weather = ForecastIO.forecast(41.87, -87.62)
    min_temp = current_weather.daily.data[0].temperatureMin
    # return (min_temp.round.to_s) + " °F"
    min_temp
  end

  def chance_of_rain
    ForecastIO.api_key = '521aad1331e6f66d7bf1ed4ec06b9aa3'
    current_weather = ForecastIO.forecast(41.87, -87.62)
    chance_of_rain = current_weather.daily.data[0].precipProbability
    # return ((chance_of_rain * 100).round.to_s + "%")
    chance_of_rain
  end

  def weather_summary
    ForecastIO.api_key = '521aad1331e6f66d7bf1ed4ec06b9aa3'
    current_weather = ForecastIO.forecast(41.87, -87.62)
    summary = current_weather.daily.data[0].summary
    return summary
  end

  def make_temperature_statement(temp)
    temp_message = "Thermostat setting: Hell. Enjoy :)" if temp < 200
    temp_message = "You wait all year for days like today. Put on your fresh fits and get out there!" if temp < 80
    temp_message = "Brisk, chilly, cool, nippy, crisp, whatever... the point is, today is 'jacket weather'" if temp < 60
    temp_message = "It's colder than Matt Baker's general disposition, put on more than a white tee! " if temp < 40
    temp_message = "Why do you live in Chicago...? It's stupid-cold out! Wear everything" if temp < 20
    temp_message
  end

  def make_precipitation_statement(precip)
    rain_message = "And it's raining. No really, look outside" if precip < 1.0
    rain_message = "And it's probably going to rain today. You have galoshes...? Didn't think so" if precip < 0.5
    rain_message = "And there's a slight chance of rain but I wouldn't worry too much" if precip < 0.3
    rain_message = "And it's definitely not going to rain today. Great success!" if precip < 0.05
    rain_message
  end

  def generate_fashion_quote
    [
      ["Fashion is never finished",  "Fake Mark Zuckerberg"],
      ["If you look good, you feel good. If you feel good, you play good. If you play good, they pay good", "Deion Sanders"],
      ["What fun is it being cool if you can't wear a sombrero?",  "Bill Watterson"]
      ["Sweatpants are a sign of defeat. You lost control of your life so you bought some sweatpants.",  "Karl Lagerfeld"]
      ["Looking good isn’t self-importance; it’s self-respect.",  "Charles Hix"]
      ["If I think about it too much, I can’t get dressed.",  "Daphne Guinness"]
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
end



# def daily_forecast(latitude, longitude)
#     ForecastIO.api_key = '521aad1331e6f66d7bf1ed4ec06b9aa3'
#     current_weather = ForecastIO.forecast(session[:latitude], session[:longitude])
#     forecast = []
#     summary = current_weather.daily.data[0].summary
#     maxTemp = current_weather.daily.data[0].temperatureMax
#     minTemp = current_weather.daily.data[0].temperatureMin
#     chanceOfRain = current_weather.daily.data[0].precipProbability
#     forecast << summary << maxTemp << minTemp << chanceOfRain
#     forecast
#   end
