require 'rails_helper'

describe Outfit do
  
  let(:tshirt) {FactoryGirl.build(:category, :name => "T-Shirt", :type_of => "Top", :layerable => 0, :min_temp => 0, :max_temp => 100, :formality => 0)}
  let(:jeans) {FactoryGirl.build(:category, :name => "Jeans", :type_of => "Bottom", :min_temp => 0, :max_temp => 80, :formality => 0)}
  let(:sneakers) {FactoryGirl.build(:category, :name => "Sneakers", :type_of => "Shoes", :min_temp => 0, :max_temp => 100, :formality => 0)}

  let(:firebase) {FactoryGirl.build(:article, :category => tshirt)}
  let(:levis) {FactoryGirl.build(:article, :category => jeans)}
  let(:nikes) {FactoryGirl.build(:article, :category => sneakers)}

  let(:joe) {FactoryGirl.build(:user)}
  let(:wardrobe) {FactoryGirl.build(:wardrobe, :user => joe, :articles => [firebase, levis, nikes])}

  let (:outfit) {FactoryGirl.build(:outfit, :wardrobe => wardrobe)}

  # before(:each) do
  #  @user = User.create(first_name: "Joe", last_name: "Bags", email: "Joe@Bags.com", password: "boom")
  #  @top = Category.create!(name: "Dress Shirts", type_of: "Top", layerable: 1, min_temp: 0, max_temp: 100, formality: 1)
  #  @bottom = Category.create!(name: "Dress Pants", type_of: "Bottom", layerable: 0, min_temp: 0, max_temp: 100, formality: 1)
  #  @shoes = Category.create!(name: "Dress Shoes", type_of: "Shoes", layerable: 0, min_temp: 0, max_temp: 100, formality: 1)
  #  @socks = Category.create!(name: "Casual Socks", type_of: "Socks", layerable: 0, min_temp: 0, max_temp: 100, formality: 1)
  #  @wardrobe = @user.wardrobes.create!
  #  [@top, @bottom, @shoes, @socks].each do |category|
  #    @wardrobe.articles.create!(category: category,
  #                               primary_color: 'red',
  #                               formal?: [true].sample,
  #                               water_proof?: [true].sample,
  #                               water_delicate?: [false].sample,
  #                               times_worn: 0)
  #  end



  # end

  it 'should be a type of Outfit' do
    expect(outfit).to be_kind_of(Outfit)
  end

  describe '.make_outfit' do 

    context 'reasonable temp, no rain, casual' do 
      it 'should make an outfit' do
        created_outfit = Outfit.make_outfit(wardrobe, 74, false, false)
        expect(created_outfit[:bottom]).to eq(levis)
        expect(created_outfit[:shoes]).to eq(nikes)
        expect(created_outfit[:tops]).to eq([firebase])
      end
    end

    context 'formal dress code' do

      context 'no formal cloths' do 
        it 'should return an outfit and error' do 
          created_outfit = Outfit.make_outfit(wardrobe, 74, false, true)
          expect([created_outfit[:bottom], created_outfit[:shoes], created_outfit[:tops]]).to eq([levis, nikes, [firebase]])
          expect(created_outfit[:errors]).to include("Had trouble finding clothes with proper dress code!")
        end
      end

      context 'one formal item' do 
        it 'should use formal item and give error' do
          dress_shirt = FactoryGirl.build(:category, :name => "Dress Shirt", :type_of => "Top", :layerable => 1, :min_temp => 0, :max_temp => 100, :formality => 1)
          brooks_bros = FactoryGirl.build(:article, :category => dress_shirt)
          wardrobe.articles << brooks_bros
          created_outfit = Outfit.make_outfit(wardrobe, 74, false, true)
          expect([created_outfit[:bottom], created_outfit[:shoes], created_outfit[:tops]]).to eq([levis, nikes, [firebase, brooks_bros]])
          expect(created_outfit[:errors]).to include("Had trouble finding clothes with proper dress code!")
        end
      end


    end



  end

end
