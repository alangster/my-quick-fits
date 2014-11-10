class CreateOutfitArticles < ActiveRecord::Migration
  def change
    create_table :outfit_articles do |t|
    	t.belongs_to :outfit
    	t.belongs_to :article
    	
      t.timestamps
    end
  end
end
