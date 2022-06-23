class PublicRecipesController < ApplicationController
    skip_before_action :authenticate_user!, only: [:index]
    def index
      @public_recipe = Recipe.where(public: true).order('created_at DESC')
    end

    def show; end
end
