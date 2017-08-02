module RaterHelper
  def rated?(hotel_id)
    Rate.where(rater_id: current_user.id, rateable_id: hotel_id).exists?
  end
end