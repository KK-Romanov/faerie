class CreateSteps < ActiveRecord::Migration[6.1]
  def change
    create_table :steps do |t|
      t.references :recipe, null: false, foreign_key: true
      t.text :direction
      t.string :image

      t.timestamps
    end
  end
end
