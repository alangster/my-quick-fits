require 'test_helper'

class OutfitTest < ActiveSupport::TestCase
   test "that we can make an outfit" do
   	outfit = Outfit.make_outfit(wardrobe, 70, false, 0)
   assert outfit.valid?
   assert outfit.#has a top
   assert outfit.#has a bottom
   assert outfit.#has a shoes
   end
end
