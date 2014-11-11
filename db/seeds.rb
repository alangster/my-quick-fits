User.delete_all
Wardrobe.delete_all
Outfit.delete_all
OutfitArticle.delete_all
Article.delete_all
Category.delete_all

# CATEGORIES
Category.create!(name: "T-Shirt", type_of: "Top", layerable: 0, min_temp: 60, max_temp: 100, formality: 0)
Category.create!(name: "Tanktop", type_of: "Top", layerable: 0, min_temp: 70, max_temp: 100, formality: 0)
# Category.create!(name: "Undershirts", type_of: "Top", layerable: 0, min_temp: 60, max_temp: 100, formality: 0)
Category.create!(name: "Long Sleeve T-Shirt", type_of: "Top", layerable: 0, min_temp: 45, max_temp: 70, formality: 0)
Category.create!(name: "Polo Shirt", type_of: "Top", layerable: 0, min_temp: 60, max_temp: 100, formality: 1)

Category.create!(name: "Button Down Shirt", type_of: "Top", layerable: 1, min_temp: 50, max_temp: 80, formality: 0)
Category.create!(name: "Dress Shirt", type_of: "Top", layerable: 1, min_temp: 50, max_temp: 80, formality: 1)

Category.create!(name: "Crewneck Sweater", type_of: "Top", layerable: 2, min_temp: 45, max_temp: 70, formality: 1) # can be either biz casual or casual...
Category.create!(name: "Cardigan", type_of: "Top", layerable: 2, min_temp: 45, max_temp: 70, formality: 1) # can be either biz casual or casual...
Category.create!(name: "V Neck Sweater", type_of: "Top", layerable: 2, min_temp: 45, max_temp: 70, formality: 1) # can be either biz casual or casual...
Category.create!(name: "Half-Zip Sweater", type_of: "Top", layerable: 2, min_temp: 45, max_temp: 70, formality: 1) # can be either biz casual or casual...
Category.create!(name: "Hooded Pullover Sweatshirt", type_of: "Top", layerable: 2, min_temp: 45, max_temp: 70, formality: 0)
Category.create!(name: "Full-Zip Hooded Sweatshirt", type_of: "Top", layerable: 2, min_temp: 45, max_temp: 70, formality: 0)
Category.create!(name: "Crewneck Sweatshirt", type_of: "Top", layerable: 2, min_temp: 45, max_temp: 70, formality: 0)

Category.create!(name: "Blazer", type_of: "Top", layerable: 3, min_temp: 40, max_temp: 75, formality: 1)
Category.create!(name: "Peacoat", type_of: "Top", layerable: 3, min_temp: 0, max_temp: 65, formality: 1)
Category.create!(name: "Down Jacket", type_of: "Top", layerable: 3, min_temp: 0, max_temp: 60, formality: 0)
Category.create!(name: "Trench Coat", type_of: "Top", layerable: 3, min_temp: 20, max_temp: 65, formality: 1)
Category.create!(name: "Rain Jacket", type_of: "Top", layerable: 3, min_temp: 35, max_temp: 70, formality: 0)

Category.create!(name: "Dress Pants", type_of: "Bottom", layerable: 0, min_temp: 0, max_temp: 100, formality: 1)
Category.create!(name: "Jeans", type_of: "Bottom", layerable: 0, min_temp: 0, max_temp: 80, formality: 0) # can be either biz casual or casual...
Category.create!(name: "Chino Pants", type_of: "Bottom", layerable: 0, min_temp: 35, max_temp: 100, formality: 1)
Category.create!(name: "Corduroy Pants", type_of: "Bottom", layerable: 0, min_temp: 0, max_temp: 70, formality: 1) # can be either biz casual or casual...
Category.create!(name: "Cargo Pants", type_of: "Bottom", layerable: 0, min_temp: 0, max_temp: 80, formality: 0) 
Category.create!(name: "Sweatpants", type_of: "Bottom", layerable: 0, min_temp: 0, max_temp: 80, formality: 0) 

Category.create!(name: "Chino Shorts", type_of: "Bottom", layerable: 0, min_temp: 60, max_temp: 100, formality: 0)
Category.create!(name: "Athletic Shorts", type_of: "Bottom", layerable: 0, min_temp: 60, max_temp: 100, formality: 0)
Category.create!(name: "Cargo Shorts", type_of: "Bottom", layerable: 0, min_temp: 60, max_temp: 100, formality: 0)
Category.create!(name: "Jean Shorts", type_of: "Bottom", layerable: 0, min_temp: 60, max_temp: 100, formality: 0)

Category.create!(name: "Dress Shoes", type_of: "Shoes", layerable: 0, min_temp: 0, max_temp: 80, formality: 1) 
Category.create!(name: "Desert Boots", type_of: "Shoes", layerable: 0, min_temp: 0, max_temp: 80, formality: 1) # can be either biz casual or casual...
Category.create!(name: "Penny Loafers", type_of: "Shoes", layerable: 0, min_temp: 0, max_temp: 100, formality: 1) 
Category.create!(name: "Sneakers", type_of: "Shoes", layerable: 0, min_temp: 0, max_temp: 100, formality: 0) 
Category.create!(name: "TOMs", type_of: "Shoes", layerable: 0, min_temp: 40, max_temp: 100, formality: 0) 
Category.create!(name: "Flip-Flops", type_of: "Shoes", layerable: 0, min_temp: 60, max_temp: 100, formality: 0) 
Category.create!(name: "Sandals", type_of: "Shoes", layerable: 0, min_temp: 60, max_temp: 100, formality: 0) 

Category.create!(name: "Down Vest", type_of: "Vest", layerable: 2, min_temp: 0, max_temp: 65, formality: 0)
Category.create!(name: "Business Vest", type_of: "Vest", layerable: 1, min_temp: 0, max_temp: 80, formality: 1)

Category.create!(name: "Casual Socks", type_of: "Socks", layerable: 0, min_temp: 0, max_temp: 100, formality: 0)
Category.create!(name: "Dress Socks", type_of: "Socks", layerable: 0, min_temp: 0, max_temp: 100, formality: 1)

Category.create!(name: "Classic Tie", type_of: "Tie", layerable: 0, min_temp: 0, max_temp: 100, formality: 1)
Category.create!(name: "Bow Tie", type_of: "Tie", layerable: 0, min_temp: 0, max_temp: 100, formality: 1)

Category.create!(name: "Dress Belt", type_of: "Belt", layerable: 0, min_temp: 0, max_temp: 100, formality: 1)
Category.create!(name: "Casual Belt", type_of: "Belt", layerable: 0, min_temp: 0, max_temp: 100, formality: 0)


# TYPES 

# Type.create!(name: "Shirt") # 1
# Type.create!(name: "Pants") # 2
# Type.create!(name: "Shoes") # 3
# Type.create!(name: "Sweater") # 4
# Type.create!(name: "Sweatshirt") # 5
# Type.create!(name: "Vest") # 6
# Type.create!(name: "Jacket") # 7
# Type.create!(name: "Socks") # 8
# Type.create!(name: "Ties") # 9
# Type.create!(name: "Shorts") # 10
# Type.create!(name: "Belts") # 11

# top
# bottom
# socks
# belt
# tie
# vest
# shoes

# layerable: t-shirt/undershirt (0 - layerable), button up/polo (1), sweater/cardigan/vest/hoodie (2), jacket/blazer (3)

User.create!(first_name: "Joe", last_name: "Bags", email: "joe@bags.com", password: "boom")
User.create!(first_name: "Tester", last_name: "Beta", email: "test@test.com", password: "test")
User.create!(first_name: "Alex", last_name: "Lang", email: "alex@lang.com", password: "jquery")
User.create!(first_name: "Isaac", last_name: "Keith", email: "isaac@keith.com", password: "sideshow")
User.create!(first_name: "Aaron", last_name: "Pee", email: "aaron@pee.com", password: "anime")

COLOR_HEXES =  {
  "Alice Blue"=>"#f0f8ff", 
  "Antique White"=>"#faebd7", 
  "Aqua"=>"#00ffff", 
  "Aquamarine"=>"#7fffd4", 
  "Azure"=>"#f0ffff", 
  "Beige"=>"#f5f5dc", 
  "Bisque"=>"#ffe4c4", 
  "Black"=>"#000000", 
  "Blanched Almond"=>"#ffebcd", 
  "Blue"=>"#0000ff", 
  "Blue Violet"=>"#8a2be2", 
  "Brown"=>"#a52a2a", 
  "Burly Wood"=>"#deb887", 
  "Cadet Blue"=>"#5f9ea0", 
  "Chartreuse"=>"#7fff00", 
  "Chocolate"=>"#d2691e", 
  "Coral"=>"#ff7f50", 
  "Cornflower Blue"=>"#6495ed", 
  "Cornsilk"=>"#fff8dc", 
  "Crimson"=>"#dc143c", 
  "Cyan"=>"#00ffff", 
  "Dark Blue"=>"#00008b", 
  "Dark Cyan"=>"#008b8b", 
  "Dark Goldenrod"=>"#b8860b", 
  "Dark Gray"=>"#a9a9a9", 
  "Dark Green"=>"#006400", 
  "Dark Khaki"=>"#bdb76b", 
  "Dark Magenta"=>"#8b008b", 
  "Dark Olive Green"=>"#556b2f", 
  "Dark Orange"=>"#ff8c00", 
  "Dark Orchic"=>"#9932cc", 
  "Dark Red"=>"#8b0000", 
  "Dark Salmon"=>"#e9967a", 
  "Dark Sea Green"=>"#8fbc8b", 
  "Dark Slate Blue"=>"#483d8b", 
  "Dark Slate Gray"=>"#2f4f4f", 
  "Dark Turquoise"=>"#00ced1", 
  "Dark Violet"=>"#9400d3", 
  "Deep Pink"=>"#ff1493", 
  "Deep Sky Blue"=>"#00bfff", 
  "Dim Gray"=>"#696969", 
  "Dodger Blue"=>"#1e90ff", 
  "Firebrick"=>"#b22222", 
  "Floral White"=>"#fffaf0", 
  "Forest Green"=>"#228b22", 
  "Fuchsia"=>"#ff00ff", 
  "Gainsboro"=>"#dcdcdc", 
  "Ghost White"=>"#f8f8ff", 
  "Gold"=>"#ffd700", 
  "Goldenrod"=>"#daa520", 
  "Gray"=>"#808080", 
  "Green"=>"#008000", 
  "Green Yellow"=>"#adff2f", 
  "Honeydew"=>"#f0fff0", 
  "Hot Pink"=>"#ff69b4", 
  "Indian Red"=>"#cd5c5c", 
  "Indigo"=>"#4b0082", 
  "Ivory"=>"#fffff0", 
  "Khaki"=>"#f0e68c", 
  "Lavender"=>"#e6e6fa", 
  "Lawn Green"=>"#7cfc00", 
  "Lemon Chiffon"=>"#fffacd", 
  "Light Blue"=>"#add8e6", 
  "Light Coral"=>"#f08080", 
  "Light Cyan"=>"#e0ffff", 
  "Light Goldenrod Yellow"=>"#fafad2", 
  "Light Gray"=>"#d3d3d3", 
  "Light Green"=>"#90ee90", 
  "Light Pink"=>"#ffb6c1", 
  "Light Salmon"=>"#ffa07a", 
  "Light Sea Green"=>"#20b2aa", 
  "Light Sky Blue"=>"#87cefa", 
  "Light Slate Gray"=>"#778899", 
  "Light Steel Blue"=>"#b0c4de", 
  "Light Yellow"=>"#ffffe0", 
  "Lime"=>"#00ff00", 
  "Lime Green"=>"#32cd32", 
  "Linen"=>"#faf0e6", 
  "Magenta"=>"#ff00ff", 
  "Maroon"=>"#800000", 
  "Medium Aquamarine"=>"#66cdaa", 
  "Medium Blue"=>"#0000cd", 
  "Medium Orchid"=>"#ba55d3", 
  "Medium Purple"=>"#9370db", 
  "Medium Sea Green"=>"#3cb371", 
  "Medium Slate Blue"=>"#7b68ee", 
  "Medium Spring Green"=>"#00fa9a", 
  "Medium Turquoise"=>"#48d1cc", 
  "Medium Violet Red"=>"#c71585", 
  "Midnight Blue"=>"#191970", 
  "Mint Cream"=>"#f5fffa", 
  "Misty Rose"=>"#ffe4e1", 
  "Moccasin"=>"#ffe4b5", 
  "Navajo White"=>"#ffdead", 
  "Navy"=>"#000080", 
  "Old Lace"=>"#fdf5e6", 
  "Olive"=>"#808000", 
  "Olive Drab"=>"#6b8e23", 
  "Orange"=>"#ffa500", 
  "Orange Red"=>"#ff4500", 
  "Orchid"=>"#da70d6", 
  "Pale Goldenrod"=>"#eee8aa", 
  "Pale Green"=>"#98fb98", 
  "Pale Turquoise"=>"#afeeee", 
  "Pale Violet Red"=>"#db7093", 
  "Papaya Whip"=>"#ffefd5", 
  "Peach Puff"=>"#ffdab9", 
  "Peru"=>"#cd853f", 
  "Pink"=>"#ffc0cb", 
  "Plum"=>"#dda0dd", 
  "Powder Blue"=>"#b0e0e6", 
  "Purple"=>"#800080", 
  "Red"=>"#ff0000", 
  "Rosy Brown"=>"#bc8f8f", 
  "Royal Blue"=>"#4169e1", 
  "Saddle Brown"=>"#8b4513", 
  "Salmon"=>"#fa8072", 
  "Sandy Brown"=>"#f4a460", 
  "Sea Green"=>"#2e8b57", 
  "Sea Shell"=>"#fff5ee", 
  "Sienna"=>"#a0522d", 
  "Silver"=>"#c0c0c0", 
  "Sky Blue"=>"#87ceeb", 
  "Slate Blue"=>"#6a5acd", 
  "Slate Gray"=>"#708090", 
  "Snow"=>"#fffafa", 
  "Spring Green"=>"#00ff7f", 
  "Steel Blue"=>"#4682b4", 
  "Tan"=>"#d2b48c", 
  "Teal"=>"#008080", 
  "Thistle"=>"#d8bfd8", 
  "Tomato"=>"#ff6347", 
  "Turquoise"=>"#40e0d0", 
  "Violet"=>"#ee82ee", 
  "Wheat"=>"#f5deb3", 
  "White"=>"#ffffff", 
  "White Smoke"=>"#f5f5f5", 
  "Yellow"=>"#ffff00", 
  "Yellow Green"=>"#9acd32"
}

COLORS = ["Alice Blue", "Antique White", "Aqua", "Aquamarine", "Azure", "Beige", "Bisque", "Black", "Blanched Almond", "Blue", "Blue Violet", "Brown", "Burly Wood", "Cadet Blue", "Chartreuse", "Chocolate", "Coral", "Cornflower Blue", "Cornsilk", "Crimson", "Cyan", "Dark Blue", "Dark Cyan", "Dark Goldenrod", "Dark Gray", "Dark Green", "Dark Khaki", "Dark Magenta", "Dark Olive Green", "Dark Orange", "Dark Orchic", "Dark Red", "Dark Salmon", "Dark Sea Green", "Dark Slate Blue", "Dark Slate Gray", "Dark Turquoise", "Dark Violet", "Deep Pink", "Deep Sky Blue", "Dim Gray", "Dodger Blue", "Firebrick", "Floral White", "Forest Green", "Fuchsia", "Gainsboro", "Ghost White", "Gold", "Goldenrod", "Gray", "Green", "Green Yellow", "Honeydew", "Hot Pink", "Indian Red", "Indigo", "Ivory", "Khaki", "Lavender", "Lawn Green", "Lemon Chiffon", "Light Blue", "Light Coral", "Light Cyan", "Light Goldenrod Yellow", "Light Gray", "Light Green", "Light Pink", "Light Salmon", "Light Sea Green", "Light Sky Blue", "Light Slate Gray", "Light Steel Blue", "Light Yellow", "Lime", "Lime Green", "Linen", "Magenta", "Maroon", "Medium Aquamarine", "Medium Blue", "Medium Orchid", "Medium Purple", "Medium Sea Green", "Medium Slate Blue", "Medium Spring Green", "Medium Turquoise", "Medium Violet Red", "Midnight Blue", "Mint Cream", "Misty Rose", "Moccasin", "Navajo White", "Navy", "Old Lace", "Olive", "Olive Drab", "Orange", "Orange Red", "Orchid", "Pale Goldenrod", "Pale Green", "Pale Turquoise", "Pale Violet Red", "Papaya Whip", "Peach Puff", "Peru", "Pink", "Plum", "Powder Blue", "Purple", "Red", "Rosy Brown", "Royal Blue", "Saddle Brown", "Salmon", "Sandy Brown", "Sea Green", "Sea Shell", "Sienna", "Silver", "Sky Blue", "Slate Blue", "Slate Gray", "Snow", "Spring Green", "Steel Blue", "Tan", "Teal", "Thistle", "Tomato", "Turquoise", "Violet", "Wheat", "White", "White Smoke", "Yellow", "Yellow Green"]
NEUTRALS = ["Black", "White", "Grey", "Brown", "Navy", "Beige", "Bisque", "Blanched Almond", "Burly Wood", "Chocolate", "Cornsilk", "Dark Goldenrod", "Dark Gray", "Dark Khaki", "Dim Gray","Floral White", "Gainsboro", "Ghost White","Gray", "Honeydew", "Indigo", "Light Gray", "Slate Gray", "Midnight Blue", "Moccasin", "Navajo White", "Peru", "Saddle Brown", "Sienna", "Snow", "Tan", "Wheat", "White Smoke"]

User.all.each do |user|
  wardrobe = user.wardrobes.create!
  20.times do 
    category = Category.all.sample
    color = COLORS.sample
    second_color = COLORS.sample
    third_color = COLORS.sample
    wardrobe.articles.create!(category: category, 
                              primary_color: color, 
                              primary_color_hex: COLOR_HEXES[color],
                              secondary_color: second_color, 
                              secondary_color_hex: COLOR_HEXES[second_color],
                              tertiary_color: third_color, 
                              tertiary_color_hex: COLOR_HEXES[third_color],
                              formal?: [true, false].sample, 
                              water_proof?: [true, false].sample,
                              water_delicate?: [false, false, false, false, false, false, true].sample,
                              times_worn: 0)
  end

  20.times do 
    category = Category.all.sample
    color = NEUTRALS.sample
    second_color = COLORS.sample
    third_color = COLORS.sample
    wardrobe.articles.create!(category: category, 
                              primary_color: color, 
                              primary_color_hex: COLOR_HEXES[color],
                              secondary_color: second_color, 
                              secondary_color_hex: COLOR_HEXES[second_color],
                              tertiary_color: third_color, 
                              tertiary_color_hex: COLOR_HEXES[third_color],
                              formal?: [true, false].sample, 
                              water_proof?: [true, false].sample,
                              water_delicate?: [false, false, false, false, false, false, true].sample,
                              times_worn: 0)
  end

end