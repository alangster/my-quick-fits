module HamburgerHelper

  def to_rgb(hex)
    hex.delete('#').scan(/\S{2}/).map(&:hex)
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
