class Cat < ApplicationRecord
  belongs_to :user
  has_many :images, class_name: "CatImage", dependent: :destroy

  validates :catname, presence: true, length: { maximum: 50 }
  validates :catprofile, presence: true
  
  has_many :favorites, dependent: :destroy
  has_many :unlike, through: :favorites, source: :user, dependent: :destroy
end
