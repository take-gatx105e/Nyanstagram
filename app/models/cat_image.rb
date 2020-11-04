class CatImage < ApplicationRecord
  belongs_to :cat

  validates :alt_text, presence: true

  has_one_attached :profile_cat_image
  acts_as_list scope: :cat

  attribute :new_profile_cat_image

  validates :new_profile_cat_image, presence: { on: :create }

  validate if: :new_profile_cat_image do
    if new_profile_cat_image.respond_to?(:content_type)
      unless new_profile_cat_image.content_type.in?(ALLOWED_CONTENT_TYPES)
        errors.add(:new_profile_cat_image, :invalid_cat_image_type)
      end
    else
      errors.add(:new_profile_cat_image, :invalid)
    end
  end

  before_save do
    if new_profile_cat_image
      self.profile_cat_image = new_profile_cat_image
    end
  end
end
