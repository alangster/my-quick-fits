module HamburgerHelper

  def icon_name(name)
  	name.gsub(" ", "-") + ".png"
    # self.category.name.gsub(" ", "-") + ".png"
  end

  def asset_icon_name(name)
    ActionController::Base.helpers.asset_path(icon_name(name))
  end

end