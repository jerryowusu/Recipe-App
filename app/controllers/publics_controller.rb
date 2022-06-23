class PublicsController < ApplicationController
    skip_before_action :authenticate_user!, only: %i[index]
  
    # GET /publics or /publics.json
    def index
      @recipes = Recipe.includes(:recipe_foods).where(public: true).order('created_at DESC')
    end
  
    # GET /publics/1 or /publics/1.json
    def show; end
  
    # GET /publics/new
    def new
      @public = Public.new
    end
  
    # GET /publics/1/edit
    def edit; end
  
    # POST /publics or /publics.json
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
  
    # PATCH/PUT /publics/1 or /publics/1.json
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
  
    # DELETE /publics/1 or /publics/1.json
    def destroy
      @public.destroy
  
      respond_to do |format|
        format.html { redirect_to publics_url, notice: 'Public was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  
    private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_public
      @public = Public.find(params[:id])
    end
  
    # Only allow a list of trusted parameters through.
    def public_params
      params.fetch(:public, {})
    end
end