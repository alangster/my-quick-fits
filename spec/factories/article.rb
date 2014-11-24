FactoryGirl.define do 
	factory :article do
		primary_color {'Navy'}
		primary_color_hex {'#000080'} 
		secondary_color {'Navajo White'}
		secondary_color_hex {'#FFDEAD'}
		formal? {false}
		water_proof? {false}

		factory :non_neutral do
			primary_color {'Red'}
			primary_color_hex {'#FF0000'}
		end

	end 
end 