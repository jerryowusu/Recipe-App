class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food

  validates :quantity, numericality: { greater_than_or_equal_to: 1 }
  # validates :food_id, presence: true
  # validates :recipe_id, presence: true

  def self.value(id)
    recipe_food = RecipeFood.find(id)
    Food.find(recipe_food.food_id).price * recipe_food.quantity
  end
end
