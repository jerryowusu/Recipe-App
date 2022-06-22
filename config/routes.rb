Rails.application.routes.draw do
  get 'recipe_foods/new'
  get 'recipe_foods/create'
  get 'recipe_foods/edit'
  get '/public_recipes', to: 'recipes#public_recipes'
  get 'foods/index'
  get 'foods/new'
  get 'foods/create'
  get 'foods/destroy'
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :foods, only: %i[index new create destroy]
  resources :recipes, only: %i[index show new create destroy] do
    resources :recipe_foods, only: %i[new create edit update destroy]
  end

  get '/public_recipes', to: 'recipes#public_recipes'
  root to: 'foods#index'
end
