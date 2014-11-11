require 'test_helper'

class WardrobeTest < ActiveSupport::TestCase
  test "wardrobes " do
    wardrobe = Wardrobe.first
    assert wardrobe.valid?, "wardrobe should be valid"
    wardrobe.user = nil
    assert_not wardrobe.valid?, "wardrobe must haz user, so they are no longer valid"
  end
end
