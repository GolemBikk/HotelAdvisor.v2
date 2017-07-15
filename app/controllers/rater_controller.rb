class RaterController < ApplicationController

  def create
    if user_signed_in?
      Rails.logger.info("INFO klass: #{params[:klass]}")
      Rails.logger.info("INFO id: #{params[:id]}")
      Rails.logger.info("INFO score: #{params[:score]}")
      Rails.logger.info("INFO dimension: #{params[:dimension]}")

      obj = params[:klass].classify.constantize.find(params[:id])
      Rails.logger.info("INFO obj: #{obj}")
      Rails.logger.info("INFO current_user: #{current_user}")
      obj.rate params[:score].to_f, current_user, params[:dimension]

      render :json => true
    else
      render :json => false
    end
  end
end
