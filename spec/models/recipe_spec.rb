require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) do
    FactoryBot.create(:user, name: 'Edward', email: 'edward@domain.com', password: 'root17',
                             password_confirmation: 'root17')
  end

  let(:recipe) do
    FactoryBot.create(:recipe, name: 'Yara', preparation_time: '20', cooking_time: '15',
                               description: 'Delicious food', public: true,
                               user_id: user.id)
  end

  context 'validation' do
    it 'should be valid with valid attributes' do
      expect(recipe).to be_valid
    end

    it 'should be invalid without a name' do
      recipe.name = nil

      expect(recipe).to_not be_valid
    end

    it 'should be invalid with a description under 1 character and over 200 characters' do
      recipe.description = ''

      expect(recipe).to_not be_valid

      recipe.description = 'a' * 201

      expect(recipe).to_not be_valid
    end

    it 'should be invalid with without a public value' do
      recipe.public = nil

      expect(recipe).to_not be_valid
    end
  end

  context 'preparation_time and cooking_time columns' do
    it 'should be invalid without a preparation time' do
      recipe.preparation_time = nil

      expect(recipe).to_not be_valid
    end

    it 'should be invalid with a preparation time under 1' do
      recipe.preparation_time = 0

      expect(recipe).to_not be_valid
    end

    it 'should be invalid with a preparation time over 2880' do
      recipe.preparation_time = 1441

      expect(recipe).to_not be_valid
    end

    it 'should be invalid without a cooking time' do
      recipe.cooking_time = nil

      expect(recipe).to_not be_valid
    end

    it 'should be invalid with a cooking time under 1' do
      recipe.cooking_time = 0

      expect(recipe).to_not be_valid
    end

    it 'should be invalid with a cooking time over 2880' do
      recipe.cooking_time = 1441

      expect(recipe).to_not be_valid
    end
  end
end
