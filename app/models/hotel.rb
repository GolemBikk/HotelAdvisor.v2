class Hotel < ApplicationRecord
  resourcify
  belongs_to :user

  default_scope -> { order('updated_at DESC') }
  validates :title, presence: true,
            length: { maximum: 50 }
  validates :address, presence: true,
            length: { maximum: 75 }
  validates :price_for_room, presence: true,
            numericality: { greater_than: 0 }

  before_save :pending_status

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

  mount_base64_uploader :photo, PhotoUploader, file_name: -> (u) { u.username }
end
