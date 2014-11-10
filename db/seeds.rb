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

User.create!(first_name: "Joe", last_name: "Bags", email: "Joe@Bags.com", password: "boom")
User.create!(first_name: "Tester", last_name: "Beta", email: "test@test.com", password: "test")
User.create!(first_name: "Alex", last_name: "Lang", email: "Alex@Lang.com", password: "jquery")
User.create!(first_name: "Isaac", last_name: "Keith", email: "Isaac@Keith.com", password: "sideshow")
User.create!(first_name: "Aaron", last_name: "Pee", email: "Aaron@Pee.com", password: "anime")

colors = [['red', '#FF0000'], ['blue', '#0000FF'], ['green', '#00FF00'], ['orange', '#FF4500'], ['purple', '#8A2BE2']]
User.all.each do |user|
  wardrobe = user.wardrobes.create!
  100.times do 
    category = Category.all.sample
    color = colors.sample
    second_color = colors.sample
    third_color = colors.sample
    wardrobe.articles.create!(category: category, 
                              primary_color: color[0], 
                              primary_color_hex: color[1],
                              secondary_color: second_color[0], 
                              secondary_color_hex: second_color[1],
                              tertiary_color: third_color[0], 
                              tertiary_color_hex: third_color[1],
                              formal?: [true, false].sample, 
                              water_proof?: [true, false].sample,
                              water_delicate?: [false, false, false, false, false, false, true].sample,
                              times_worn: 0)
  end
end