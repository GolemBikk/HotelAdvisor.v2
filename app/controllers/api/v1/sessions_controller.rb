class Api::V1::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token,
                     if: -> { request.format.json? },
                     only: [:create]

  respond_to :json

  def create
    if authenticate_by_params?
      render json: resource, serializer: UserSerializer, status: 200
    else
      render json: @message, status: 400
    end
  end

  private

  def authenticate_by_params?
    self.resource = User.find_by_email(params[:user][:email])
    if resource.nil?
      @message = 'Invalid email'
      false
    elsif resource.valid_password?(params[:user][:password])
      true
    else
      @message = 'Invalid password'
      false
    end
  end
end
