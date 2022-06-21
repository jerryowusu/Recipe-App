class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods

  validates :name, presence: true
  validates :preparation_time, numericality: { in: 1..1440 }
  validates :cooking_time, numericality: { in: 1..1440 }
  validates :description, length: { in: 1..200 }
  validates :public, exclusion: [nil]
end
