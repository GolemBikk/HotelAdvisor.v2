class Hotel < ApplicationRecord
  default_scope -> { order('updated_at DESC') }
  scope :approved, -> { where(status: 'approved') }
  scope :top, -> { include('rating_cache').order(rating_cache.avg :desc).limit(5) }
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

  resourcify
  ratyrate_rateable 'title'
  mount_base64_uploader :photo, PhotoUploader, file_name: -> (u) { u.username }

  self
    def filter(args)

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
