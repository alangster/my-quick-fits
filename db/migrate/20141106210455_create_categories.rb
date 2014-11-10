class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
    	t.string 	    :type_of
    	t.string 			:name
    	t.integer 		:layerable
    	t.integer 		:min_temp
    	t.integer 		:max_temp
    	t.integer 		:formality
    	t.text 				:description
    	
      t.timestamps
    end
  end
end
