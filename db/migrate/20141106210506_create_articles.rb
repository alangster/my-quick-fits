class CreateArticles < ActiveRecord::Migration
  def change
    create_table    :articles do |t|
      t.belongs_to  :wardrobe
    	t.belongs_to  :category
      t.string      :primary_color
      t.string      :primary_color_hex
      t.string      :secondary_color
      t.string      :secondary_color_hex
      t.string      :tertiary_color
      t.string      :tertiary_color_hex
      t.string      :pattern
      t.string      :fabric
      t.boolean     :formal?
      t.boolean     :water_proof?
      t.boolean     :water_delicate?
      t.integer     :times_worn
      t.string      :condition

      t.timestamps
    end
  end
end
