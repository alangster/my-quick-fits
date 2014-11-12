require 'test_helper'

class OutfitTest < ActiveSupport::TestCase
   test "that we can make an outfit" do
   outfit = Outfit.first
   assert outfit.valid?, "it should be a valid outfit"
   outfit.wardrobe = nil
   assert_not outfit.valid?, "it needs an wardrobe (top, bottom, or shoes) so this won't be valid"
   end
end
