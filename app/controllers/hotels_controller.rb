class HotelsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :find, :except => [:index, :new]
  before_action :owner, :only => [:edit, :update, :destroy]


  def index
    page_num = params[:page] || 1
    @hotels = Hotel.rated.with_best_rate.page(page_num)
  end

  def show
    @review = Review.new
    # @reviews = Rate.where(rateable_id: @hotel.id);
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
      if current_user.id != @hotel.user_id
        flash[:danger] = 'У вас нет доступа к чужим записям'
        redirect_to root_path
      end
    end
end
