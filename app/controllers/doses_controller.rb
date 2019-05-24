class ReviewsController < ApplicationController
  def create
    @review = current_user.reviews.new(review_params)
    @review.cocktail = Cocktail.find(params[:cocktail_id])
    @cocktail = @review.cocktail

    if @review.save
      respond_to do |format|
        format.html { redirect_to cocktail_path(@cocktail) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'cocktails/show' }
        format.js
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
