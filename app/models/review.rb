class Review < ApplicationRecord
  belongs_to :rating, class_name: 'Rate'

  validates :title, presence: true,
            length: { maximum: 50 }
  validates :text, presence: true

end
