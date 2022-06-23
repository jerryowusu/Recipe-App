class ShoppingsController < ApplicationController
    def list
      @recipe_foods = RecipeFood.where(recipe_id: params[:format])
      @total_qty = @recipe_foods.map(&:quantity).inject(0, &:+)
      @totalprice = total2
    end
  
    private
  
    def total2
      @total = 0
      @recipe_foods.map { |item| @total += (item.food.price * item.quantity) }
      @total
    end
end