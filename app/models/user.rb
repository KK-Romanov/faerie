class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  # レシピ系
  has_many :recipes, dependent: :destroy
  #  コメント系
  has_many :comments, dependent: :destroy

  # いいね機能関連
  has_many :favorites, dependent: :destroy

  # has_many :favorite_recipes, through: :favorites, source: :recipe
  
  has_one_attached :profile_image
  
  # プロフィール画像header
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    # profile_image.variant(resize_to_limit: [100, 100]).processed
      profile_image.variant(resize_to_limit: [width, height]).processed
  end
  # プロフィール画像footer
  
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

end

