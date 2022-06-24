class RecipeFoodsController < ApplicationController
  before_action :set_recipe_food, only: %i[show edit update destroy]

  def index
    @recipe_foods = RecipeFood.all
  end

  def show; end

  def new
    @recipe_food = RecipeFood.new
  end

  def edit; end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)

    respond_to do |format|
      format.html do
        if @recipe_food.save
          flash[:success] = 'Recipe created successfully'
          redirect_back_or_to({ action: 'show', id: params[:recipe_id] })
        else
          flash.now[:error] = 'Error: Recipe could not be created'
          render :new
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @recipe_food.update(recipe_food_params)
        format.html { redirect_to recipe_food_url(@recipe_food), notice: 'Recipe food was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe_food }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe_food.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe_food.destroy

    respond_to do |format|
      format.html { redirect_back_or_to({ action: 'show', id: params[:recipe_id] }) }
      format.json { head :no_content }
    end
  end

  private

  def set_recipe_food
    @recipe_food = RecipeFood.find(params[:id])
  end

  def recipe_food_params
    params.fetch(:recipe_food, {}).permit(:quantity, :recipe_id, :food_id)
  end
end
