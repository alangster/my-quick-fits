require 'rails_helper'

describe Outfit do
  let (:outfit) { Outfit.new }

  before(:each) do
   @user = User.create(first_name: "Joe", last_name: "Bags", email: "Joe@Bags.com", password: "boom")
   @top = Category.create!(name: "Dress Shirts", type_of: "Top", layerable: 1, min_temp: 0, max_temp: 100, formality: 1)
   @bottom = Category.create!(name: "Dress Pants", type_of: "Bottom", layerable: 0, min_temp: 0, max_temp: 100, formality: 1)
   @shoes = Category.create!(name: "Dress Shoes", type_of: "Shoes", layerable: 0, min_temp: 0, max_temp: 100, formality: 1)
   @socks = Category.create!(name: "Casual Socks", type_of: "Socks", layerable: 0, min_temp: 0, max_temp: 100, formality: 1)
   @wardrobe = @user.wardrobes.create!
   [@top, @bottom, @shoes, @socks].each do |category|
     @wardrobe.articles.create!(category: category,
                                primary_color: 'red',
                                formal?: [true].sample,
                                water_proof?: [true].sample,
                                water_delicate?: [false].sample,
                                times_worn: 0)
   end



  end

  it 'should be a type of Outfit' do
    expect(outfit).to be_kind_of(Outfit)
  end

  it 'should make an outfit' do
    created_outfit = Outfit.make_outfit(@wardrobe, 74, false, false)
    expect(created_outfit[:bottom].id).to eq(@bottom.id)
    expect(created_outfit[:shoes].id).to eq(@shoes.id)
  end

  it 'should not make an outfit with invalid temps' do
    created_outfit = Outfit.make_outfit(@wardrobe, -74, false, false)
    expect(created_outfit[:bottom]).to eq(nil)
    expect(created_outfit[:shoes]).to eq(nil)
  end

  
  
end
