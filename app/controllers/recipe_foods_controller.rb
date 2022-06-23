# class RecipeFoodsController < ApplicationController
#   def new
#     @recipe = Recipe.find_by(id: params[:recipe_id])
#     @recipe_food = RecipeFood.new
#   end

#   def create
#     @recipe_food = RecipeFood.new(food_id: params[:food][:food_id], recipe_id: params[:recipe_id],
#                                   quantity: params[:quantity])

#     if @recipe_food.save
#       redirect_to recipes_path, notice: 'Successfully added an ingredient.'
#     else
#       render :new, alert: 'Something happened.'
#     end
#   end

#   def edit
#     @recipe_food = RecipeFood.find_by(id: params[:id])
#   end

#   def update
#     @recipe_food = RecipeFood.find_by(id: params[:id])
#     if @recipe_food.update(recipe_food_params)
#       redirect_to recipe_path(params[:recipe_id]), notice: 'Successfully modified food quantity.'
#     else
#       render :new, alert: 'Could not modify food quantity'
#     end
#   end

#   def destroy
#     @recipe_food = RecipeFood.destroy(params[:id])

#     if @recipe_food.destroyed?
#       redirect_to recipes_path, notice: 'Successfully deleted ingredient.'
#     else
#       render :new, alert: 'Could not delete ingredient.'
#     end
#   end

#   private

#   def recipe_food_params
#     params.require(:recipe_food).permit(:quantity)
#   end
# end

class RecipeFoodsController < ApplicationController
  before_action :set_recipe_food, only: %i[show edit update destroy]

  # GET /recipe_foods or /recipe_foods.json
  def index
    @recipe_foods = RecipeFood.all
  end

  # GET /recipe_foods/1 or /recipe_foods/1.json
  def show; end

  # GET /recipe_foods/new
  def new
    @recipe_food = RecipeFood.new
  end

  # GET /recipe_foods/1/edit
  def edit; end

  # POST /recipe_foods or /recipe_foods.json
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

  # PATCH/PUT /recipe_foods/1 or /recipe_foods/1.json
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

  # DELETE /recipe_foods/1 or /recipe_foods/1.json
  def destroy
    @recipe_food.destroy

    respond_to do |format|
      format.html { redirect_back_or_to({ action: 'show', id: params[:recipe_id] }) }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe_food
    @recipe_food = RecipeFood.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_food_params
    params.fetch(:recipe_food, {}).permit(:quantity, :recipe_id, :food_id)
  end
end