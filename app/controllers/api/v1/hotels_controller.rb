class Api::V1::HotelsController < ApiController
  before_action :authenticate_by_token, except: [:index, :show]
  before_action :find, except: [:index, :create]
  before_action :owner, only: [:update, :destroy]
  before_action :prepare_hotels, only: [:index]

  respond_to :json

  def index
    if @hotels.nil? || !@hotels.any?
      @error_message = 'No hotels was found by request'
      render json: @error_message, status: :not_found
    else
      render json: @hotels, each_serializer: HotelCollectionSerializer, status: :ok
    end
  end

  def show
    render json: @hotel, serializer: HotelSerializer, status: :ok
  end

  def create
    params[:user_id] = @user.id
    @hotel = Hotel.new(permitted_params)
    if @hotel.save
      @message = 'Record was created'
      render json: @message, status: :created
    else
      @error_message = @hotel.errors.messages
      render json: @error_messages , status: :bad_request
    end
  end

  def update
    if @hotel.update_attributes(permitted_params)
      @message = 'Record was updated'
      render json: @message, status: :ok
    else
      @error_message = @hotel.errors.messages
      render json: @error_messages , status: :bad_request
    end
  end

  def destroy
    @hotel.destroy
    @message = 'Record was deleted'
    render json: @message, status: :ok
  end

  private
    def find
      @hotel = Hotel.where(id: params[:id]).first
      if @hotel.nil?
        @error_message = 'Record was not found'
        render json: @error_message, status: :not_found
      end
    end

    def owner
      if @user.id != @hotel.user_id
        @error_message = 'Record belongs to another user'
        render json: @error_message, status: :forbidden
      end
    end

    def permitted_params
      params.permit(:wifi_included, :breakfast_included,
                    :room_description, :price_for_room,
                    :title, :address, :photo, :user_id)
    end

    def prepare_hotels
      check_filters
      return filtered if @filters.any?
      return for_owner if params[:user_id]
      return top if params[:top_count]
      params[:page_num] ||= 1
      params[:page_size] ||= @_default_per_page
      @hotels = Hotel.rated.page(params[:page_num]).per(params[:page_size])
    end

    def top
      @hotels = Hotel.rated_top(params[:top_count])
    end

    def for_owner
      @hotels = Hotel.rated.find_by_user_id(params[:user_id])
    end

    def filtered
      @hotels = Hotel.rated_and_filtered(@filters)
    end

    def check_filters
      @filters = {}
      params.each do |key, value|
        case key
          when 'title'
            @filters[:title] = value
          when 'address'
            @filters[:address] = value
          when 'star_rating'
            Rails.logger.info("INFO " + value)
            @filters[:star_rating] = mto_a(value)
          when 'user_rating'
            @filters[:rating_caches] = { avg: to_r(value) }
          when 'breakfast_included'
            @filters[:breakfast_included] = value
          when 'wifi_included'
            @filters[:wifi_included] = value
        end
      end
    end

    def mto_a(string)
      array = string.tr('[]','').split(',').map{|c| c.to_i}
      array
    end

    def to_r(string)
      range = string.split('..').map{|c| c.to_i}
      range[0]..range[1]
    end
end
