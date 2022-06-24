class PublicsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @recipes = Recipe.includes(:recipe_foods).where(public: true).order('created_at DESC')
  end

  def show; end

  def new
    @public = Public.new
  end

  def edit; end

  def create
    @public = Public.new(public_params)

    respond_to do |format|
      if @public.save
        format.html { redirect_to public_url(@public), notice: 'Public was successfully created.' }
        format.json { render :show, status: :created, location: @public }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @public.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @public.update(public_params)
        format.html { redirect_to public_url(@public), notice: 'Public was successfully updated.' }
        format.json { render :show, status: :ok, location: @public }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @public.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @public.destroy

    respond_to do |format|
      format.html { redirect_to publics_url, notice: 'Public was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_public
    @public = Public.find(params[:id])
  end

  def public_params
    params.fetch(:public, {})
  end
end
