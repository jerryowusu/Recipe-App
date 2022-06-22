class FoodsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def create
    new_food = Food.new(params.require(:food).permit(:name, :measurement_unit, :price))
    new_food.user = current_user

    new_food.save!
    redirect_to foods_path
  end

  def destroy
    food = Food.find(params[:id])
    return unless food.present? && food.user == current_user

    food.destroy!
    redirect_to foods_path
  end
end
