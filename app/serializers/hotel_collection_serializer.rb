class HotelCollectionSerializer < ActiveModel::Serializer
  attributes :id, :title, :address, :star_rating, :user_rating,
             :price_for_room, :photo

  def user_rating
    object.title_average.avg unless object.title_average.nil?
  end

  def rater_count
    object.title_average.qty unless object.title_average.nil?
  end

  def photo
    object.photo.mini.url
  end
end
