class RgbTriplet

	include Colorscore

	KNOWN_RGBS = {
		"Alice Blue" => Color::RGB.new(240, 248, 255),
		"Antique White" => Color::RGB.new(250, 235, 215),
		"Aqua" => Color::RGB.new(0, 255, 255),
		"Aquamarine" => Color::RGB.new(127, 255, 212),
		"Azure" => Color::RGB.new(240, 255, 255),
		"Beige" => Color::RGB.new(245, 245, 220),
		"Bisque" => Color::RGB.new(255, 228, 196),
		"Black" => Color::RGB.new(0, 0, 0),
		"Blanched Almond" => Color::RGB.new(255, 235, 205),
		"Blue" => Color::RGB.new(0, 0, 255),
		"Blue Violet" => Color::RGB.new(138, 43, 226),
		"Brown" => Color::RGB.new(165, 42, 42),
		"Burly Wood" => Color::RGB.new(222, 184, 135),
		"Cadet Blue" => Color::RGB.new(95, 158, 160),
		"Chartreuse" => Color::RGB.new(127, 255, 0),
		"Chocolate" => Color::RGB.new(210, 105, 30),
		"Coral" => Color::RGB.new(255, 127, 80),
		"Cornflower Blue" => Color::RGB.new(100, 149, 237),
		"Cornsilk" => Color::RGB.new(255, 248, 220),
		"Crimson" => Color::RGB.new(220, 20, 60),
		"Cyan" => Color::RGB.new(0, 255, 255),
		"Dark Blue" => Color::RGB.new(0, 0, 139),
		"Dark Cyan" => Color::RGB.new(0, 139, 139),
		"Dark Goldenrod" => Color::RGB.new(184, 134, 11),
		"Dark Gray" => Color::RGB.new(169, 169, 169),
		"Dark Green" => Color::RGB.new(0, 100, 0),
		"Dark Khaki" => Color::RGB.new(189, 183, 107),
		"Dark Magenta" => Color::RGB.new(139, 0, 139),
		"Dark Olive Green" => Color::RGB.new(85, 107, 47),
		"Dark Orange" => Color::RGB.new(255, 140, 0),
		"Dark Orchic" => Color::RGB.new(153, 50, 204),
		"Dark Red" => Color::RGB.new(139, 0, 0),
		"Dark Salmon" => Color::RGB.new(233, 150, 122),
		"Dark Sea Green" => Color::RGB.new(143, 188, 139),
		"Dark Slate Blue" => Color::RGB.new(72, 61, 139),
		"Dark Slate Gray" => Color::RGB.new(47, 79, 79),
		"Dark Turquoise" => Color::RGB.new(0, 206, 209),
		"Dark Violet" => Color::RGB.new(148, 0, 211),
		"Deep Pink" => Color::RGB.new(255, 20, 147),
		"Deep Sky Blue" => Color::RGB.new(0, 191, 255),
		"Dim Gray" => Color::RGB.new(105, 105, 105),
		"Dodger Blue" => Color::RGB.new(30, 144, 255),
		"Firebrick" => Color::RGB.new(178, 34, 34),
		"Floral White" => Color::RGB.new(255, 250, 240),
		"Forest Green" => Color::RGB.new(34, 139, 34),
		"Fuchsia" => Color::RGB.new(255, 0, 255),
		"Gainsboro" => Color::RGB.new(220, 220, 220),
		"Ghost White" => Color::RGB.new(248, 248, 255),
		"Gold" => Color::RGB.new(255, 215, 0),
		"Goldenrod" => Color::RGB.new(218, 165, 32),
		"Gray" => Color::RGB.new(128, 128, 128),
		"Green" => Color::RGB.new(0, 128, 0),
		"Green Yellow" => Color::RGB.new(173, 255, 47),
		"Honeydew" => Color::RGB.new(240, 255, 240),
		"Hot Pink" => Color::RGB.new(255, 105, 180),
		"Indian Red" => Color::RGB.new(205, 92, 92),
		"Indigo" => Color::RGB.new(75, 0, 130),
		"Ivory" => Color::RGB.new(255, 255, 240),
		"Khaki" => Color::RGB.new(240, 230, 140),
		"Lavender" => Color::RGB.new(230, 230, 250),
		"Lawn Green" => Color::RGB.new(124, 252, 0),
		"Lemon Chiffon" => Color::RGB.new(255, 250, 205),
		"Light Blue" => Color::RGB.new(173, 216, 230),
		"Light Coral" => Color::RGB.new(240, 128, 128),
		"Light Cyan" => Color::RGB.new(224, 255, 255),
		"Light Goldenrod Yellow" => Color::RGB.new(250, 250, 210),
		"Light Gray" => Color::RGB.new(211, 211, 211),
		"Light Green" => Color::RGB.new(144, 238, 144),
		"Light Pink" => Color::RGB.new(255, 182, 193),
		"Light Salmon" => Color::RGB.new(255, 160, 122),
		"Light Sea Green" => Color::RGB.new(32, 178, 170),
		"Light Sky Blue" => Color::RGB.new(135, 206, 250),
		"Light Slate Gray" => Color::RGB.new(119, 136, 153),
		"Light Steel Blue" => Color::RGB.new(176, 196, 222),
		"Light Yellow" => Color::RGB.new(255, 255, 224),
		"Lime" => Color::RGB.new(0, 255, 0),
		"Lime Green" => Color::RGB.new(50, 205, 50),
		"Linen" => Color::RGB.new(250, 240, 230),
		"Magenta" => Color::RGB.new(255, 0, 255),
		"Maroon" => Color::RGB.new(128, 0, 0),
		"Medium Aquamarine" => Color::RGB.new(102, 205, 170),
		"Medium Blue" => Color::RGB.new(0, 0, 205),
		"Medium Orchid" => Color::RGB.new(186, 85, 211),
		"Medium Purple" => Color::RGB.new(147, 112, 219),
		"Medium Sea Green" => Color::RGB.new(60, 179, 113),
		"Medium Slate Blue" => Color::RGB.new(123, 104, 238),
		"Medium Spring Green" => Color::RGB.new(0, 250, 154),
		"Medium Turquoise" => Color::RGB.new(72, 209, 204),
		"Medium Violet Red" => Color::RGB.new(199, 21, 133),
		"Midnight Blue" => Color::RGB.new(25, 25, 112),
		"Mint Cream" => Color::RGB.new(245, 255, 250),
		"Misty Rose" => Color::RGB.new(255, 228, 225),
		"Moccasin" => Color::RGB.new(255, 228, 181),
		"Navajo White" => Color::RGB.new(255, 222, 173),
		"Navy" => Color::RGB.new(0, 0, 128),
		"Old Lace" => Color::RGB.new(253, 245, 230),
		"Olive" => Color::RGB.new(128, 128, 0),
		"Olive Drab" => Color::RGB.new(107, 142, 35),
		"Orange" => Color::RGB.new(255, 165, 0),
		"Orange Red" => Color::RGB.new(255, 69, 0),
		"Orchid" => Color::RGB.new(218, 112, 214),
		"Pale Goldenrod" => Color::RGB.new(238, 232, 170),
		"Pale Green" => Color::RGB.new(152, 251, 152),
		"Pale Turquoise" => Color::RGB.new(175, 238, 238),
		"Pale Violet Red" => Color::RGB.new(219, 112, 147),
		"Papaya Whip" => Color::RGB.new(255, 239, 213),
		"Peach Puff" => Color::RGB.new(255, 218, 185),
		"Peru" => Color::RGB.new(205, 133, 63),
		"Pink" => Color::RGB.new(255, 192, 203),
		"Plum" => Color::RGB.new(221, 160, 221),
		"Powder Blue" => Color::RGB.new(176, 224, 230),
		"Purple" => Color::RGB.new(128, 0, 128),
		"Red" => Color::RGB.new(255, 0, 0),
		"Rosy Brown" => Color::RGB.new(188, 143, 143),
		"Royal Blue" => Color::RGB.new(65, 105, 225),
		"Saddle Brown" => Color::RGB.new(139, 69, 19),
		"Salmon" => Color::RGB.new(250, 128, 114),
		"Sandy Brown" => Color::RGB.new(244, 164, 96),
		"Sea Green" => Color::RGB.new(46, 139, 87),
		"Sea Shell" => Color::RGB.new(255, 245, 238),
		"Sienna" => Color::RGB.new(160, 82, 45),
		"Silver" => Color::RGB.new(192, 192, 192),
		"Sky Blue" => Color::RGB.new(135, 206, 235),
		"Slate Blue" => Color::RGB.new(106, 90, 205),
		"Slate Gray" => Color::RGB.new(112, 128, 144),
		"Snow" => Color::RGB.new(255, 250, 250),
		"Spring Green" => Color::RGB.new(0, 255, 127),
		"Steel Blue" => Color::RGB.new(70, 130, 180),
		"Tan" => Color::RGB.new(210, 180, 140),
		"Teal" => Color::RGB.new(0, 128, 128),
		"Thistle" => Color::RGB.new(216, 191, 216),
		"Tomato" => Color::RGB.new(255, 99, 71),
		"Turquoise" => Color::RGB.new(64, 224, 208),
		"Violet" => Color::RGB.new(238, 130, 238),
		"Wheat" => Color::RGB.new(245, 222, 179),
		"White" => Color::RGB.new(255, 255, 255),
		"White Smoke" => Color::RGB.new(245, 245, 245),
		"Yellow" => Color::RGB.new(255, 255, 0),
		"Yellow Green" => Color::RGB.new(154, 205, 50),
	}

	attr_reader :red, :green, :blue

	def initialize(rgb_arr)
		@red   = rgb_arr[0]
		@green = rgb_arr[1]
		@blue  = rgb_arr[2]
	end

	def name

		color = Color::RGB.new(red, green, blue)
		similarities = {}
		
		KNOWN_RGBS.each do |name, value| 
			similarities[name] = Metrics.similarity(color, value)
		end

		match = similarities.max_by {|name, distance| distance}

		match[0]

	end

	def to_hex
		"##{hex_helper(red.to_s(16))}#{hex_helper(green.to_s(16))}#{hex_helper(blue.to_s(16))}"

		# "#" + [red, green, blue].map { |rgb_val| rgb_val.to_s(16) }.join("")
	end

	private

	def hex_helper(hex)
		hex.to_i < 16 && hex.length < 2 ? "0#{hex}" : hex
	end

end