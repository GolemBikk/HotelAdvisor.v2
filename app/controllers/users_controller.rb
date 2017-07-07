class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]
  before_action :current_user!, only: [:show]

  def index
    params[:page] ||= 1
    @users = User.page(params[:page]).per 30
  end

  def show
    @user = User.find(params[:id])
  end

  protected

    def current_user!
      profile_id = params[:id].to_s
      current_user_id = current_user.id.to_s
      if profile_id != current_user_id
        redirect_to root_path
      end
    end
end
