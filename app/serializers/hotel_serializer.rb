class HotelSerializer < ActiveModel::Serializer
  attributes :id, :title, :address, :star_rating, :user_rating,
             :rater_count, :price_for_room, :room_description,
             :breakfast_included, :wifi_included, :photo

  def user_rating
    object.title_average.avg unless object.title_average.nil?
  end

  def rater_count
    object.title_average.qty unless object.title_average.nil?
  end

  def photo
    object.photo.medium.url
  end
end
