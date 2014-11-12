require 'test_helper'

class OutfitArticleTest < ActiveSupport::TestCase
   test "that this record is associated with an outfit" do
     outfit_article = OutfitArticle.first
     outfit_article.article = nil
     assert_not outfit_article.valid? "it needs an article (top, bottom, or shoes) so this won't be valid"
   end
end
