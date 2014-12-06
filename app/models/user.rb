class User < ActiveRecord::Base
	has_many :wardrobes
	has_many :articles, through: :wardrobes
	has_many :categories, through: :articles
	has_many :type_of, through: :categories
	has_many :outfits, through: :wardrobes
	
	has_secure_password

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true

end



