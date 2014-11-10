class OutfitArticle < ActiveRecord::Base
	belongs_to :outfit
	belongs_to :article
	
end
