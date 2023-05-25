class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :recipe, null: false, foreign_key: true
      t.text :content
      t.integer :comments
      t.integer :reply_comment
      

      t.timestamps
    end
  end
end
