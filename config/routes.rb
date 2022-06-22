Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :foods, only: [:index, :new, :create, :destroy]
 
  root to: "foods#index"
end
