class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  # validates :profile, presence: true
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  # has_many :cats, dependent: :destroy
  # has_many :relationships, dependent: :destroy
  # has_many :followings, through: :relationships, source: :follow, dependent: :destroy
  # has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  # has_many :followers, through: :reverses_of_relationship, source: :user, dependent: :destroy
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  # 自分がフォローしたユーザの投稿もにゃんこ一覧に表示させるために必要。
  def feed_cats
    Cat.where(user_id: self.following_ids + [self.id])
  end
  
  # has_many :favorites, dependent: :destroy
  # has_many :likes, through: :favorites, source: :cat, dependent: :destroy
  
  def favorite(cat)
    self.favorites.find_or_create_by(cat_id: cat.id)
  end
  
  def unfavorite(cat)
    favorite = self.favorites.find_by(cat_id: cat.id)
    favorite.destroy if favorite
  end
  
  def favorited?(cat)
    self.likes.include?(cat)
  end
end
