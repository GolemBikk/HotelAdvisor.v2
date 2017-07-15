module HotelsHelper
  def score_to_s(score)
    case score.round
      when 0..2
        'Очень плохо'
      when 3..4
        'Плохо'
      when 5..6
        'Нормально'
      when 7..8
        'Хорошо'
      when 9..10
        'Очень хорошо'
    end
  end

  def my_image_url(hotel)
    default_image = 'default.png'
    if hotel.photo
      hotel.photo.url
    else
      default_image
    end
  end
end
