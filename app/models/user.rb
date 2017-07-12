class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+[a-z\d]\.[a-z]+\z/i

  has_many :hotels, dependent: :destroy
  has_one :reviews, dependent: :destroy

  validates :first_name, presence: true,
            length: { maximum: 50 }
  validates :last_name, presence: true,
            length: { maximum: 50 }

  validates :email, presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  before_save :ensure_authentication_token!,
              :email_downcase
  after_save :default_role

  rolify
  ratyrate_rater
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def hotels_count
    Hotel.where(user_id: self.id).size
  end

  private
    def ensure_authentication_token!
      if authentication_token.blank?
        self.authentication_token = generate_authentication_token
      end
    end

    def email_downcase
      self.email.downcase!
    end

    def default_role
      self.add_role :user, Hotel
    end

    def generate_authentication_token
      loop do
        token = Devise.friendly_token
        break token unless User.where(authentication_token: token).first
      end
    end
end
