class Cocktail < ApplicationRecord
  validate :name, uniqueness: true, presence: true
  has_many :doses, dependant: :destroy
  has_many :ingredients, through: :doses
end
