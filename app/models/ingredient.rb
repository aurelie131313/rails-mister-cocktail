class Ingredient < ApplicationRecord
  validate :name, uniqueness: true, presence: true

  has_many :doses
end
