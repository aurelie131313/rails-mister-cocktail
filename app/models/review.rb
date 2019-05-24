class Review < ApplicationRecord
  belongs_to :cocktail
  belongs_to :user

  validates :rating, :content, presence: true
  validates :rating, numericality: { only_integer: true }, inclusion: { in: (0..5), allow_nil: false }
  validates :cocktail_id, uniqueness: { scope: :user_id, message: "You've already reviewed this cocktail" }
end
