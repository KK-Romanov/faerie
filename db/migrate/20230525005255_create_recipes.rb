class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      
      t.string :title 
      t.text :description
      t.float :review, default: 0
      t.integer :user_id
      
      t.timestamps
      
    end
  end
end
