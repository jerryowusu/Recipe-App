class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods
  has_many :foods, through: :recipe_foods

  def self.public_recipes
    @recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  validates :name, presence: true
  # validates :preparation_time, numericality: { in: 1..1440 }
  # validates :cooking_time, numericality: { in: 1..1440 }
  # validates :description, length: { in: 1..200 }
  # validates :public, exclusion: [nil]

  def self.total(id)
    recipe = Recipe.find(id)
    recipe.recipe_foods.joins(:recipe, :food).sum('price * quantity')
  end

  def self.items(id)
    Recipe.find(id).recipe_foods.count
  end
end
