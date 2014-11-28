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

  it 'should be a type of Outfit' do
    expect(outfit).to be_kind_of(Outfit)
  end

  describe '.make_outfit' do 

    context 'reasonable temp, no rain, casual' do 
      it 'returns make an outfit' do
        created_outfit = Outfit.make_outfit(wardrobe, 74, false, 0)
        expect(created_outfit[:bottom]).to eq(levis)
        expect(created_outfit[:shoes]).to eq(nikes)
        expect(created_outfit[:tops]).to eq([firebase])
      end
    end

    context 'formal dress code' do

      let(:dress_shirt) {FactoryGirl.build(:category, :name => "Dress Shirt", :type_of => "Top", :layerable => 1, :min_temp => 0, :max_temp => 100, :formality => 1)}
      let(:brooks_bros) {FactoryGirl.build(:article, :category => dress_shirt, :primary_color => "White")}

      let(:dress_pants) {FactoryGirl.build(:category, :name => "Dress Pants", :type_of => "Bottom", :layerable => 0, :min_temp => 0, :max_temp => 80, :formality => 1)}
      let(:ludlow)      {FactoryGirl.build(:article, :category => dress_pants, :primary_color => "Grey")}

      let(:dress_shoes) {FactoryGirl.build(:category, :name => "Dress Shoes", :type_of => "Shoes", :layerable => 0, :min_temp => 0, :max_temp => 100, :formality => 1)}
      let(:alden)       {FactoryGirl.build(:article, :category => dress_shoes, :primary_color => "Brown")}

      context 'no formal articles' do 
        it 'returns an outfit and error' do 
          created_outfit = Outfit.make_outfit(wardrobe, 74, false, 1)
          expect([created_outfit[:bottom], created_outfit[:shoes], created_outfit[:tops]]).to eq([levis, nikes, [firebase]])
          expect(created_outfit[:errors]).to include("Had trouble finding clothes with proper dress code!")
        end
      end

      context 'one formal article' do 
        it 'returns outfit with formal article and error' do
          wardrobe.articles << brooks_bros
          created_outfit = Outfit.make_outfit(wardrobe, 74, false, 1)
          expect([created_outfit[:bottom], created_outfit[:shoes], created_outfit[:tops]]).to eq([levis, nikes, [firebase, brooks_bros]])
          expect(created_outfit[:errors]).to include("Had trouble finding clothes with proper dress code!")
        end
      end

      context 'sufficient formal articles' do 
        it 'returns all formal outfit' do 
          wardrobe.articles << [brooks_bros, ludlow, alden]
          created_outfit = Outfit.make_outfit(wardrobe, 74, false, 1)
          expect([created_outfit[:bottom], created_outfit[:shoes], created_outfit[:tops]]).to eq([ludlow, alden, [firebase, brooks_bros]])
        end
      end

    end

    context 'precipitation' do 

      context 'no water-proof or water-resistant articles' do 
        it 'returns outfit and error' do
          wardrobe_2 = FactoryGirl.build(:wardrobe)
          wardrobe_2.articles << [
            FactoryGirl.build(:article, :category => tshirt, :water_delicate? => true),
            FactoryGirl.build(:article, :category => jeans, :water_delicate? => true),
            FactoryGirl.build(:article, :category => sneakers, :water_delicate? => true)
            ]
          created_outfit = Outfit.make_outfit(wardrobe_2, 70, true, 0)
          expect(created_outfit[:errors]).to include("Had trouble finding water-resistant clothes!")
        end
      end

      context 'one water-proof article' do 
        it 'returns outfit using that article' do 
          wardrobe_2 = FactoryGirl.build(:wardrobe)
          water_delicate_shirt = FactoryGirl.build(:article, :category => tshirt, :water_delicate? => true)
          water_proof_shirt    = FactoryGirl.build(:article, :category => tshirt, :water_delicate? => false)

          wardrobe_2.articles << [
            water_delicate_shirt,
            water_proof_shirt,
            FactoryGirl.build(:article, :category => jeans, :water_delicate? => true),
            FactoryGirl.build(:article, :category => sneakers, :water_delicate? => true)
          ]
          created_outfit = Outfit.make_outfit(wardrobe_2, 70, true, 0)
          expect(created_outfit[:tops]).to eq([water_proof_shirt])
          expect(created_outfit[:errors]).to include("Had trouble finding water-resistant clothes!")
        end
      end

    end

  end

  describe '.get_modified_name' do 

    let(:results) {{
      complementary:     true,
      proper_dress_code: true,
      water_resistant:   true,
      good_condition:    true,
      clean:             true,
      within_temp:       true
      }}

    context 'no article' do 
      it 'returns blank string' do
        expect(Outfit.get_modified_name(nil, results)).to eq("")
      end
    end

    context 'article and error' do 
      it 'returns name with *' do 
        results[:proper_dress_code] = false
        expect(Outfit.get_modified_name(firebase, results)).to eq("T-Shirt *")
      end
    end

    context 'article and two errors' do 
      it 'returns name with *' do 
        results[:proper_dress_code], results[:good_condition] = false, false
        expect(Outfit.get_modified_name(firebase, results)).to eq("T-Shirt *")
      end
    end

  end

  

end
