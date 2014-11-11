require 'test_helper'

class OutfitTest < ActiveSupport::TestCase
   test "that we can make an outfit" do
   outfit = Outfit.first
   assert outfit.valid?, "it should be a valid outfit"
   outfit.outfit_article = nil
   assert_not outfit.valid?, "it needs an outfit_article (top, bottom, or shoes) so this won't be valid"
   outfit = Outfit.first
   outfit.wardrobe = nil
   assert_not outfit.valid?, "it needs an wardrobe (top, bottom, or shoes) so this won't be valid"
   outfit = Outfit.first
   articles_in_my_outfit = outfit.articles
   t = articles_in_my_outfit.count {|article| article.category.type_of == "Top"}
   assert t >= 1
   b = articles_in_my_outfit.count {|article| article.category.type_of == "Bottom"}
   assert b == 1
   s = articles_in_my_outfit.count {|article| article.category.type_of == "Shoes"}
   assert s == 1
   end
end
