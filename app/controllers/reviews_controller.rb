class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    rate = Rate.find_by_user_id_and_hotel_id current_user.id, params[:review][:hotel_id]
    params[:review][:rate_id] = rate.id
    @review = Review.new(permitted_params)

    if @review.save
      render :json => true
    else
      render :json => false
    end
  end

  def update

  end

  private
    def permitted_params
      params.require(:review).permit(:title, :text, :rate_id)
    end
end
