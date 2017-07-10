class HotelsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  def index
    params[:page] ||= 1
    Hotel.all.page(params[:page]).per 30
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
    find
  end

  def update
    if @hotel.update_attributes(permitted_params)
      redirect_to hotels_path
    else
      render :edit
    end
  end

  def destroy
    find
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
end
