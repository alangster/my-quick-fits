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

		it 'returns true if temp within article temp range' do 
			expect(firebase.within_temp?(70)).to eq(true)
		end


		it 'returns true if temp at top of article temp range' do 
			expect(firebase.within_temp?(100)).to eq(true)
		end


		it 'returns true if temp at bottom of article temp range' do 
			expect(firebase.within_temp?(60)).to eq(true)
		end

		it 'returns false if temp outside article temp range' do 
			expect(firebase.within_temp?(59)).to eq(false)
		end

	end

end