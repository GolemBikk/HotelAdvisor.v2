class Review < ApplicationRecord
  default_scope -> { order('created_at DESC') }
  scope :by_user, ->(user_id) { where(user_id: user_id) }
  scope :by_hotel, ->(hotel_id) { where(user_id: hotel_id) }

  belongs_to :user
  belongs_to :hotel

  validates :title, presence: true,
            length: { maximum: 50 }
  validates :text, presence: true

end
