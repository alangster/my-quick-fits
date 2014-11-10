class Bottom < Article

	attr_reader :no_no

	NO_NOS = {
		"Dress Pants"     => ["Sneakers", "TOMs", "Flip-Flops", "Sandals", "T-Shirt", "Tanktop", "Long-Sleeve T-Shirt", "Crewneack, Sweatshirt", "Hooded Pullover Sweatshirt", "Full-Zip Hooded Sweatshirt"],
		"Jeans"           => ["Dress Shoes"],
		"Chino Pants"     => ["Flip-Flops"],
		"Corduroy Pants"  => ["Tanktop", "Dress Shoes", "Flip-Flops", "Sandals"],
		"Cargo Pants"     => ["Dress Shirt", "Blazer", "Dress Shoes"],
		"Sweatpants"      => ["Polo Shirt", "Button Down Shirt", "Dress Shirt", "Cardigan", "Crewneck Sweater", "Half-Zip Sweater", "Blazer", "Peacoat", "Dress Shoes", "Desert Boots", "Penny Loafers"],
		"Chino Shorts"    => ["Dress Shirt", "Dress Shoes", "Desert Boots"],
		"Athletic Shorts" => ["Polo Shirt", "Button Down Shirt", "Dress Shirt", "Cardigan", "Crewneck Sweater", "Half-Zip Sweater", "Blazer", "Peacoat", "Dress Shoes", "Desert Boots", "Penny Loafers"],
		"Cargo Shorts"    => ["Polo Shirt", "Button Down Shirt", "Dress Shirt", "Cardigan", "Crewneck Sweater", "Half-Zip Sweater", "Blazer", "Peacoat", "Dress Shoes", "Desert Boots", "Penny Loafers"],
		"Jean Shorts"     => ["Polo Shirt", "Button Down Shirt", "Dress Shirt", "Cardigan", "Crewneck Sweater", "Half-Zip Sweater", "Blazer", "Peacoat", "Dress Shoes", "Desert Boots", "Penny Loafers"]
	}

	def initialize(type)
		@no_no = NO_NOS[type]
	end

end