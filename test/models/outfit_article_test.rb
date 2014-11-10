require 'test_helper'

class OutfitArticleTest < ActiveSupport::TestCase
   test "that this record is associated with an outfit" do
     assert outfit_article_1.valid?
     assert outfit_article_1.#has a top
   end
end
