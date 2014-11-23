require 'rails_helper'

describe Article do 

	let!(:joe) {User.find_by_first_name("Joe")}
	let!(:firebase) {joe.articles.first}

	describe '#good_condition?' do 

		it 'returns true if no condition' do 
			expect(firebase.good_condition?).to eq(true)
		end

		it 'returns false if condition specified' do 
			foursquare = joe.articles[1]
			foursquare.condition = "torn"
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
			let(:blue_suede_shoes) {Article.new(water_delicate?: true)}
			it 'returns false' do
				expect(blue_suede_shoes.water_resistant?).to eq(false)
			end
		end

		context 'waterproof article' do 
			let(:patagonia_rain_jacket) {Article.new(water_proof?: true)}
			it 'returns true' do
				expect(patagonia_rain_jacket.water_resistant?).to eq(true)
			end
		end

	end

	describe '#proper_dress_code?' do 

		let(:navy_blazer) {Article.new(category: Category.find_by_name("Blazer"))}

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
			Article.new(primary_color: "Black"),
			Article.new(primary_color: "Grey"),
			Article.new(primary_color: "Peru")
			]}

		let(:one_non_neutral) {[
			Article.new(primary_color: "Sienna"),
			Article.new(primary_color: "Snow"),
			Article.new(primary_color: "Pink")
			]}

		let(:purple) {Article.new(primary_color: "Purple")}	

		context 'all neutral other articles' do 

			context 'neutral article' do 
				it 'returns true' do 
					expect(firebase.complementary?(other_neutral_articles)).to eq(true)
				end
			end

			context 'non-neutral article' do
				it 'returns true' do 
					expect(purple.complementary?(other_neutral_articles)).to eq(true)
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
					expect(purple.complementary?(one_non_neutral)).to eq(false)
				end
			end

		end

	end

	describe '#render_gradient' do 

		context 'article with only primary color' do 
			it 'returns gradient with only primary color' do 
				red = Article.new(primary_color_hex: '#FF0000')
				expect(red.render_gradient).to eq("background: linear-gradient(#FF0000 50%,#FF0000 50%,#FF0000)")
			end
		end

		context 'article with primary and secondary colors' do
			it 'returns gradient with secondary twice' do 
				expect(firebase.render_gradient).to eq("background: linear-gradient(#808080 50%,#ffa500 50%,#ffa500)")
			end
		end

		context 'article with primary, secondary, and tertiary colors' do 
			it 'returns gradient with three colors' do
				three = Article.new(primary_color_hex: '#FF0000', secondary_color_hex: '#168090', tertiary_color_hex: '#00FFFF')
				expect(three.render_gradient).to eq("background: linear-gradient(#FF0000 50%,#168090 50%,#00FFFF)")
			end
		end

	end

end