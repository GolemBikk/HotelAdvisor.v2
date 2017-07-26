class StaticPagesController < ApplicationController

  def home
    # flash[:warning] = 'Некоторый текст для сообщения'
    # flash[:info] = 'Некоторый текст для сообщения'
    # flash[:danger] = 'Некоторый текст для сообщения'
    # flash[:success] = 'Некоторый текст для сообщения'
    count = 5
    @hotels = Hotel.rated_top(count)
  end

  def help
  end

  def about
  end

  def contact
  end

end
