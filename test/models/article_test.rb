require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "articles should have appropriate properties" do
    article = Article.first
    assert article.valid?, "article should be valid"
    article.category = nil
    assert article.valid?, "article needs a category so this is invalid"
    article = Article.first
    article.wardrobe = nil
    assert article.valid?, "article needs a wardrobe so this is invalid"
    article = Article.first
  article.primary_color =
  assert article.valid?, "article should have a primary_color so this is invalid"
  article = Article.first
    article.fabric =
  assert article.valid?, "article should have a fabric so this is invalid"
   end
end
