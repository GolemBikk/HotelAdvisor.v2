class ReviewsController < ApplicationController
  def create
    @review = Review.new(permitted_params)

    if @review.save

    end
  end

  private
    def permitted_params
      params.require(:review).permit(:title, :text, :hotel_id, :user_id)
    end
end
