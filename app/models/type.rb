class Type < ActiveRecord::Base
	has_many :categories
	has_many :articles, through: :categories

	def select_item
		@items = Item.all
		@items = @items.available(condition, times_worn)
		@items = @items.appropriate(temp, h20, formal)
		@items.sample
	end


end
