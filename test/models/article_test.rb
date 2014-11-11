require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "articles should have appropriate properties" do
    article = Article.first
    assert article.valid?, "article should be valid"
    article.category = nil
    assert_not article.valid?, "article needs a category so this is invalid"
    article.wardrobe = nil
    assert_not article.valid?, "article needs a wardrobe so this is invalid"
    article.primary_color = nil
    assert_not article.valid?, "article should have a primary_color so this is invalid"
    article.fabric = nil
    assert_not article.valid?, "article should have a fabric so this is invalid"
   end
end
