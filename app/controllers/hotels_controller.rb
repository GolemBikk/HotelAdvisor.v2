class HotelsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :owner, :only => [:edit, :update, :destroy]

  def index
    params[:page] ||= 1
    @hotels = Hotel.all.page(params[:page]).per 30
  end

  def show
    find
  end

  def new
    @hotel = Hotel.new
  end

  def create
    @hotel = Hotel.new(permitted_params)

    if @hotel.save
      redirect_to hotels_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @hotel.update_attributes(permitted_params)
      redirect_to hotels_path
    else
      render :edit
    end
  end

  def destroy
    @hotel.destroy

    redirect_to hotels_path
  end

  private

    def find
      @hotel = Hotel.find(params[:id])
    end

    def permitted_params
      params.require(:hotel).permit(:wifi_included, :breakfast_included,
                                    :room_description, :price_for_room,
                                    :title, :address, :photo, :user_id)
    end

    def owner
      find
      if current_user.id != @hotel.user_id
        flash[:error] = 'У вас нет доступа к чужим записям'
        redirect_to root_path
      end
    end
end
