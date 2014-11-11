class OutfitArticle < ActiveRecord::Base
	belongs_to :outfit
	belongs_to :article

  validates :article, presence: true

end
