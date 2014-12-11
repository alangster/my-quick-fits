require 'rails_helper'

describe ApplicationHelper do 

	describe '#article_color_data' do 

		context 'given a non-empty string' do 
			it 'returns color name and hex value' do
				expect(article_color_data("24,188,200")[0]).to match(/[A-Z][a-z]+/)
				expect(article_color_data("24,188,200")[1]).to match(/#[a-f0-9]{6}/)
			end
		end

		context 'given an empty string' do
			it 'returns array of nils' do
				expect(article_color_data("")).to eq([nil, nil])
			end
		end
	end

	describe '#color_name' do

		context 'given non-nil hex' do
			it 'returns an accurate color name' do
				expect(color_name('#006400')).to eq("Dark Green")
			end
		end

		context 'given a nil hex' do
			it 'returns nil' do
				expect(color_name(nil)).to be_nil
			end
		end

	end

	describe '#dark?' do

		context 'given a dark colored rgb triplet' do
			it 'returns true' do
				expect(dark?('#2f4f4f')).to be_truthy
			end
		end

		context 'given a light colored rgb triplet' do
			it 'returns false' do
				expect(dark?('#191970')).to be_truthy
			end
		end

		context 'given a light colored hex' do
			it 'returns false' do
				expect(dark?('#add8e6')).to be_falsy
			end
		end

	end

	describe '#item_counts' do

		before do
			@categories = [
				FactoryGirl.build(:category, :type_of => "Top", :name => "T-Shirt"),
				FactoryGirl.build(:category, :type_of => "Bottom", :name => "Chinos"),
				FactoryGirl.build(:category, :type_of => "Top", :name => "Sweater"),
				FactoryGirl.build(:category, :type_of => "Shoes", :name => "Sneakers"),
				FactoryGirl.build(:category, :type_of => "Bottom", :name => "Jeans")
			]
			@articles = [
				FactoryGirl.build(:article, :category => @categories[0]),
				FactoryGirl.build(:article, :category => @categories[0]),
				FactoryGirl.build(:article, :category => @categories[1]),
				FactoryGirl.build(:article, :category => @categories[2]),
				FactoryGirl.build(:article, :category => @categories[2]),
				FactoryGirl.build(:article, :category => @categories[1]),
				FactoryGirl.build(:article, :category => @categories[1]),
				FactoryGirl.build(:article, :category => @categories[3]),
				FactoryGirl.build(:article, :category => @categories[3]),
				FactoryGirl.build(:article, :category => @categories[3]),
				FactoryGirl.build(:article, :category => @categories[3])
			]
		end

		it 'returns items with correct counts' do
			expect(item_counts(@articles.map {|article| article.category}).map {|arr| [arr[0].name, arr[1]]}).to eq([["Sneakers", 4], ["Chinos", 3], ["Sweater", 2], ["T-Shirt", 2]])
		end

	end

end