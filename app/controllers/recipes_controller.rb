class RecipesController < ApplicationController
  def index
    @recipes = Recipe.where(user_id: current_user&.id)
  end

  def show
    @recipe = Recipe.find(params[:id])
    if !@recipe.public && current_user != @recipe.user
      if user_signed_in?
        flash[:notice] = 'You are not authorized to access this page'
        redirect_to recipes_path
      else
        flash[:notice] = 'You must be logged in to access this page'
        redirect_to new_user_session_path
      end
    else
      @recipe
    end
  end
  
  def new
    if current_user
      @recipe = Recipe.new
    else
      redirect_to root_path, alert: 'You need to login in order to add a recipe'
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipes_path, alert: 'Successfully created recipe'
    else
      render :new, alert: 'Could not create recipe'
    end
  end

  def destroy
    @recipe = Recipe.destroy(params[:id])

    if @recipe.destroyed?
      redirect_to recipes_path, alert: 'Successfully deleted recipe'
    else
      render :new, alert: 'Could not delete recipe'
    end
  end

  def public_recipes
    @recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  private

  def recipe_params
    recipe_hash = params.require(:recipe).permit(:name, :description, :cooking_time, :preparation_time, :public)
    recipe_hash[:user] = current_user
    recipe_hash
  end
end
