class CocktailsController < ApplicationController
  before_action :set_cocktail, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @cocktails = Cocktail.all.order("created_at DESC")
    if params[:search]
      @cocktails = Cocktail.search(params[:search]).order("created_at DESC")
    elsif params[:id]
      @user =User.find(params[:id])
      @cocktails = @user.cocktails.all
    else
      @cocktails = Cocktail.all.order("created_at DESC")
    end
  end

  def show
    @dose = Dose.new
    @review = Review.new
  end

  def new
    @cocktail = current_user.cocktails.new
  end

  def edit
    if current_user != @cocktail.user
      redirect_to edit_cocktail_path(@cocktail)
    end
    @dose = Dose.new
  end

  def create
    @cocktail = current_user.cocktails.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def update
    if @cocktail.update(cocktail_params)
      redirect_to cocktail_path(@cocktail), notice: "Cocktail Updated"
    else
      render :edit
    end
  end

  def destroy
    @cocktail.destroy
    redirect_to cocktails_path
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :about, :instructions, :photo, :photo_cache)
  end
end
