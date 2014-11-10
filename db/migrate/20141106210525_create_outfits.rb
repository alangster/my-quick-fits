class CreateOutfits < ActiveRecord::Migration
  def change
    create_table :outfits do |t|
    	t.belongs_to 		:wardrobe
    	t.integer 			:like
    	t.string 				:name
    	
      t.timestamps
    end
  end
end
