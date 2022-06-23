Rails.application.routes.draw do
 
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # get 'shopping/list'
  get "/general_shopping_list", to: 'shoppings#list'
  resources :publics, only: %i[index]
  resources :recipes, only: %i[index new create destroy show]
  resources :foods, only: %i[index new create destroy show]
  resources :recipe_foods, only: %i[index new create destroy show edit]

  get '/public_recipes', to: 'publics#index'
  root to: 'publics#index'
end
