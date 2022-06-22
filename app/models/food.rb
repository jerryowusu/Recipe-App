class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  # has_many :recipes, through: :recipe_foods

  # has_many :inventory_foods
  # has_many :inventories, through: :inventory_foods

  validates :name, presence: true, length: { in: 1..255 }
  validates :measurement_unit, presence: true, length: { maximum: 255 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
