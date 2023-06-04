class User < ApplicationRecord
  # レシピ系
  has_many :recipes, dependent: :destroy
  #  コメント系
  has_many :comments

  # いいね機能関連
  has_many :favorites, dependent: :destroy

  has_many :favorite_recipes, through: :favorites, source: :recipe
  
  def already_favorited?(recipe)
    self.favorites.exists?(recipe_id: recipe.id)
  end
  
  def self.guest
    find_or_create_by!(email: 'guest@example.com', name: 'ゲストユーザー') do |user|
      o = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
      user.password = (0..19).map { o[rand(o.length)] }.join
      user.password_confirmation = user.password
    end
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         

end
