require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:user) do
    FactoryBot.create(:user, name: 'Edward', email: 'edward@domain.com', password: 'root17',
                             password_confirmation: 'root17')
  end

  let(:recipe) do
    FactoryBot.create(:recipe, name: 'Yara', preparation_time: '20', cooking_time: '15',
                               description: 'Delicious food', public: true,
                               user_id: user.id)
  end

  let(:food) do
    FactoryBot.create(:food,
                      name: 'Apple',
                      measurement_unit: 'grams',
                      price: 1.15,
                      user:)
  end

  let(:recipe_food) do
    FactoryBot.create(:recipe_food, quantity: 3, food_id: food.id, recipe_id: recipe.id)
  end

  context 'validation' do
    it 'should be valid with valid attributes' do
      expect(recipe_food).to be_valid
    end

    it 'should be invalid without a quantity' do
      recipe_food.quantity = nil

      expect(recipe_food).to_not be_valid
    end

    it 'should be invalid with 0 quantity' do
      recipe_food.quantity = 0

      expect(recipe_food).to_not be_valid
    end

    it 'should be invalid without a food_id' do
      recipe_food.food_id = nil

      expect(recipe_food).to_not be_valid
    end

    it 'should be invalid without a recipe_id' do
      recipe_food.recipe_id = nil

      expect(recipe_food).to_not be_valid
    end
  end
end
