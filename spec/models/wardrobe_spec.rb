require 'rails_helper'

describe Wardrobe do 

	let(:user)       {FactoryGirl.create(:user)}
	let(:wardrobe)   {FactoryGirl.create(:wardrobe, :user => user)}
	
	let(:bottom_cat) {FactoryGirl.create(:category, :type_of => 'Bottom', :layerable => 0)}
	let(:shirts_cat) {FactoryGirl.create(:category, :type_of => 'Top', :layerable => 0)}
	let(:coats_cat)  {FactoryGirl.create(:category, :type_of => 'Top', :layerable => 2)}
	let(:shoes_cat)  {FactoryGirl.create(:category, :type_of => 'Shoes', :layerable => 0)} 
	
	let(:shirts)     {Array.new(4) {FactoryGirl.create(:article, :category => shirts_cat)}}
	let(:coats)      {Array.new(1) {FactoryGirl.create(:article, :category => coats_cat)}}
	let(:pants)      {Array.new(3) {FactoryGirl.create(:article, :category => bottom_cat)}}
	let(:shoes)      {Array.new(2) {FactoryGirl.create(:article, :category => shoes_cat)}}

	let(:worn)       {Array.new(5) {FactoryGirl.create(:outfit, :like => rand(0..4))}}
	let(:unworn)     {Array.new(2) {FactoryGirl.create(:outfit, :like => -1)}}

	before do
		wardrobe.outfits << worn + unworn
		wardrobe.articles << shirts + coats + pants + shoes
	end

	after do
		Wardrobe.destroy_all
		Category.destroy_all
		Article.destroy_all
		User.destroy_all
		OutfitArticle.destroy_all
	end

	describe '#worn_outfits' do

		context 'many outfits, not all worn' do 
			it 'returns only worn outfits' do
				expect(wardrobe.worn_outfits).to eq(worn)
			end
		end

	end

	describe '#get_all_tops' do
		it 'returns only tops of specified layer' do
			expect(wardrobe.get_all_tops(0)).to eq(shirts)
			expect(wardrobe.get_all_tops(1)).to be_empty
			expect(wardrobe.get_all_tops(2)).to eq(coats)
		end
	end

	describe '#get_all_bottoms' do
		it 'returns all bottoms' do
			expect(wardrobe.get_all_bottoms).to eq(pants)
		end
	end

	describe '#get_all_shoes' do
		it 'returns all shoes' do
			expect(wardrobe.get_all_shoes).to eq(shoes)
		end
	end

	describe '#color_percentages' do

		context 'all navy items' do
			it 'returns 100% navy' do
				expect(wardrobe.color_percentages).to eq({:neutrals=>[{"Navy"=>100.0}]})
			end
		end

		context 'multiple colors' do
			it 'returns correct percentages' do
				red_articles = Array.new(10) {FactoryGirl.create(:article, :category => [bottom_cat, shirts_cat, shoes_cat].sample, :primary_color => "Red")}
				gray_articles = Array.new(5) {FactoryGirl.create(:article, :category => [bottom_cat, shirts_cat, shoes_cat].sample, :primary_color => "Gray")}
				navy_articles = Array.new(5) {FactoryGirl.create(:article, :category => [bottom_cat, shirts_cat, shoes_cat].sample)}

				wardrobe_2 = FactoryGirl.create(:wardrobe, :user => user)
				wardrobe_2.articles << red_articles + gray_articles + navy_articles
				expect(wardrobe_2.color_percentages).to eq({:neutrals => [{"Gray" => 25.0}, {"Navy" => 25.0}], :colors => [{"Red" => 50.0}]})
			end
		end

	end

	describe '#any_other_formal_tops' do

		context 'no formal tops' do
			it 'returns false' do
				expect(wardrobe.any_other_formal_tops?(shirts[0])).to be_falsy
			end
		end

		context 'other formal tops' do
			it 'returns true' do
				formal = FactoryGirl.create(:category, :type_of => "Top", :layerable => 1, :formality => 1)
				wardrobe.articles << FactoryGirl.create(:article, :category => formal)
				expect(wardrobe.any_other_formal_tops?(shirts[0])).to be_truthy
			end
		end

	end

end