class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :user, foreign_key: true, null: false
      t.references :recipe, foreign_key: true, null: false

      # 0で評価したい人もいることを考えてデフォルト値は0に設定
      t.float :review, default: 0

      t.timestamps
    end
  end
end