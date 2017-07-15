class Hotel < ApplicationRecord
  default_scope -> { includes(:title_average).references(:title_average)
                                                   .order('hotels.updated_at DESC')}
  scope :approved, -> { where(status: 'approved') }
  scope :top, -> { order('rating_caches.avg DESC').limit(5) }
  scope :max_price, -> { maximum :price_for_room }

  belongs_to :user
  has_many :reviews, dependent: :destroy

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
  mount_base64_uploader :photo, PhotoUploader, file_name: -> (u) { u.username }

  def self.filter(args)

  end

  def rating
    RatingCache.find_by_cacheable_id(self.id).avg
  end

  def rater_count
    RatingCache.find_by_cacheable_id(self.id).qty
  end

  private
    def pending_status
      self.status = 'pending'
    end

    def by_title(sample)

    end

    def by_address(address)

    end
end
