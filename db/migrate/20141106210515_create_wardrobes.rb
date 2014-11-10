class CreateWardrobes < ActiveRecord::Migration
  def change
    create_table :wardrobes do |t|
    	t.belongs_to :user
    	t.string		 :name
      t.timestamps
    end
  end
end
