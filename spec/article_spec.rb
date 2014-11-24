require 'rails_helper'

describe Article do 

	let!(:joe) {FactoryGirl.build(:user)}
	let!(:tshirt) {FactoryGirl.build(:category, :name => "T-Shirt", :min_temp => 60, :max_temp => 100, :formality => 0)}
	let!(:blazer) {FactoryGirl.build(:category, :formality => 1)}
	let!(:firebase) {FactoryGirl.build(:article, :category => tshirt)}
	let(:navy_blazer) {FactoryGirl.build(:article, :category => blazer)}


	describe '#good_condition?' do 

		it 'returns true if no condition' do 
			expect(firebase.good_condition?).to eq(true)
		end

		it 'returns false if condition specified' do 
			foursquare = FactoryGirl.build(:article, :condition => "ripped")
			expect(foursquare.good_condition?).to eq(false)
		end

	end	

	describe '#within_temp?' do 

		context 'temp within article temp range' do 
			it 'returns true' do 
				expect(firebase.within_temp?(70)).to eq(true)
			end
		end

		context 'temp at top of article temp range' do 
			it 'returns true' do 
				expect(firebase.within_temp?(100)).to eq(true)
			end
		end

		context 'temp at bottom of article temp range' do 
			it 'returns true' do 
				expect(firebase.within_temp?(60)).to eq(true)
			end
		end

		context 'temp below article temp range' do 
			it 'returns false' do 
				expect(firebase.within_temp?(59)).to eq(false)
			end
		end

		context 'temp above article temp range' do 
			it 'returns false' do 
				expect(firebase.within_temp?(101)).to eq(false)
			end
		end

	end

	describe '#water_resistant?' do 

		context 'not water delicate article' do 
			it 'returns true' do 
				expect(firebase.water_resistant?).to eq(true)
			end
		end

		context 'water delicate article' do
			let(:blue_suede_shoes) {FactoryGirl.build(:article, :water_delicate? => true)}
			it 'returns false' do
				expect(blue_suede_shoes.water_resistant?).to eq(false)
			end
		end

		context 'waterproof article' do 
			let(:patagonia_rain_jacket) {FactoryGirl.build(:article, :water_proof? => true)}
			it 'returns true' do
				expect(patagonia_rain_jacket.water_resistant?).to eq(true)
			end
		end

	end

	describe '#proper_dress_code?' do 

		context 'formal dress code' do

			context 'formal item' do 
				it 'returns true' do
					expect(navy_blazer.proper_dress_code?(1)).to eq(true)
				end
			end

			context 'informal item' do 
				it 'returns false' do 
					expect(firebase.proper_dress_code?(1)).to eq(false)
				end
			end

		end

		context 'informal dress code' do 

			context 'formal item' do
				it 'returns false' do 
					expect(navy_blazer.proper_dress_code?(0)).to eq(false)
				end
			end

			context 'informal item' do 
				it 'returns true' do
					expect(firebase.proper_dress_code?(0)).to eq(true)
				end
			end

		end

	end

	describe '#is_neutral?' do

		context 'neutral item' do
			it 'returns true' do
				expect(firebase.is_neutral?).to eq(true)
			end
		end

		context 'non-neutral item' do
			it 'returns false' do 
				pink = Article.new(primary_color: "Pink")
				expect(pink.is_neutral?).to eq(false)
			end
		end

	end

	describe '#complementary' do 

		let(:other_neutral_articles) {[
			FactoryGirl.build(:article),
			FactoryGirl.build(:article, :primary_color => "Grey"),
			FactoryGirl.build(:article)
			]}

		let(:one_non_neutral) {other_neutral_articles << FactoryGirl.build(:non_neutral)}

		let(:non_neut) {FactoryGirl.build(:non_neutral)}	

		context 'all neutral other articles' do 

			context 'neutral article' do 
				it 'returns true' do 
					expect(firebase.complementary?(other_neutral_articles)).to eq(true)
				end
			end

			context 'non-neutral article' do
				it 'returns true' do 
					expect(non_neut.complementary?(other_neutral_articles)).to eq(true)
				end
			end

		end

		context 'one non-neutral in other articles' do 

			context 'neutral article' do 
				it 'returns true' do 
					expect(firebase.complementary?(one_non_neutral)).to eq(true)
				end
			end

			context 'non-neutral article' do
				it 'returns false' do 
					expect(non_neut.complementary?(one_non_neutral)).to eq(false)
				end
			end

		end

	end

	describe '#render_gradient' do 

		context 'article with only primary color' do 
			it 'returns gradient with only primary color' do 
				red = FactoryGirl.build(:article, :primary_color_hex => '#FF0000', :secondary_color_hex => nil)
				expect(red.render_gradient).to eq("background: linear-gradient(#FF0000 50%,#FF0000 50%,#FF0000)")
			end
		end

		context 'article with primary and secondary colors' do
			it 'returns gradient with secondary twice' do 
				expect(firebase.render_gradient).to eq("background: linear-gradient(#000080 50%,#FFDEAD 50%,#FFDEAD)")
			end
		end

		context 'article with primary, secondary, and tertiary colors' do 
			it 'returns gradient with three colors' do
				three = FactoryGirl.build(:article, :tertiary_color_hex => '#00FFFF')
				expect(three.render_gradient).to eq("background: linear-gradient(#000080 50%,#FFDEAD 50%,#00FFFF)")
			end
		end

	end

end