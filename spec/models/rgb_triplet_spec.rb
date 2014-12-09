require 'rails_helper'

describe RgbTriplet do 

	let(:green) {RgbTriplet.new([0, 255, 0])}
	let(:rgb)   {RgbTriplet.new([47, 190, 220])}

	describe '#initialize' do 

		it 'has a red value' do 
			expect(green.red).to eq(0)
			expect(rgb.red).to eq(47)
		end

		it 'has a green value' do 
			expect(green.green).to eq(255)
			expect(rgb.green).to eq(190)
		end

		it 'has a blue value' do 
			expect(green.blue).to eq(0)
			expect(rgb.blue).to eq(220)
		end

	end

	describe '#name' do 

		pending 'returns an accurate name' do 
			# How on earth can I actually test this?
		end

	end

	describe '#to_hex' do

		it 'returns accurate hex value' do
			expect(green.to_hex).to eq("#00ff00")
			expect(rgb.to_hex).to eq("#2fbedc")
		end

	end

end