class Dose < ApplicationRecord
  belongs_to :cocktail
  belongs_to :ingredient

  validates_uniqueness_of :cocktail_id, scope: :ingredient_id

  def ingredient_name
    ingredient.try(:name)
  end

  def ingredient_name=(name)
    self.ingredient = Ingredient.find_or_create_by_name(name) if name.present?
  end
end
