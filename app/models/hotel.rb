class Hotel < ApplicationRecord
  default_scope -> { order('hotels.created_at DESC') }
  scope :approved, -> { where(status: 'approved') }
  scope :for_owner, -> (user_id) { find_by_user_id(user_id) }
  scope :sorted_by, -> (field, value) { reorder("hotels.#{field} #{value}") }
  scope :max_price_for_room, -> { approved.maximum :price_for_room }
  scope :with_best_rate, -> { includes(:best_rate) }
  scope :rated, -> { includes(:title_average) }
  scope :rated_and_filtered, -> (filters) { rated.where(filters) }
  scope :rated_top, -> (top_count) {
    joins(:title_average).reorder('rating_caches.avg DESC').limit(top_count)
  }

  belongs_to :user
  has_one :best_rate,
          -> { with_rater.with_review },
          class_name: 'Rate', foreign_key: :rateable_id

  validates :title, presence: true,
            length: { maximum: 50 }
  validates :address, presence: true,
            length: { maximum: 75 }
  validates :price_for_room, presence: true,
            numericality: { greater_than: 0 }

  before_save :pending_status

  paginates_per 9
  resourcify
  ratyrate_rateable 'title'
  mount_base64_uploader :photo,
                        PhotoUploader,
                        file_name: -> (u) { u.title }

  private
    def pending_status
      self.status = 'pending'
    end
end
