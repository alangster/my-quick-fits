require 'rails_helper'

describe Category do 

	NECESSITIES = ["T-Shirt", "Polo Shirt", "Button Down Shirt", "Dress Shirt", "Blazer", "Down Jacket", "Rain Jacket", "Dress Pants", "Jeans", "Chino Shorts", "Dress Shoes", "Sneakers"]
	
	let(:wardrobe)       {FactoryGirl.build(:wardrobe)}
	let(:all_categories) {NECESSITIES.map {|cat| FactoryGirl.build(:category, :name => cat)}}
	let(:all_articles)   {all_categories.map {|cat| FactoryGirl.build(:article, :category => cat)}}

	describe '.find_missing' do

		context 'complete wardrobe' do
			it 'returns an empty array' do
				wardrobe.articles << all_articles
				expect(Category.find_missing(wardrobe)).to be_empty
			end
		end

		context 'incomplete wardrobe' do
			it 'returns array of missing categories' do 
				wardrobe.articles << (all_articles.drop(2))
				expect(Category.find_missing(wardrobe).map(&:name)).to contain_exactly("T-Shirt", "Polo Shirt")
			end
		end

	end

	describe '#fav_color' do

		context 'mostly red chinos' do 
			it 'returns red' do 
				colors = Array.new(4, "Red") + Array.new(3, "Blue") << "Pink" 
				chino = FactoryGirl.create(:category, :name => "Chinos")
				chinos_array = colors.map {|color| FactoryGirl.create(:article, :primary_color => color, :category => chino)}
				wardrobe.articles << all_articles + chinos_array
				expect(chino.fav_color(wardrobe)).to eq("Red")
			end
		end
		
	end



end