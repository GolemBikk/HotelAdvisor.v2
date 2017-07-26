class Rate < ActiveRecord::Base
  default_scope -> { select('rates.*').order(stars: :desc) }
  scope :with_review, -> { joins(:review).select('reviews.*') }
  scope :with_rater, -> {
    joins(:rater).select('users.id, users.first_name, users.last_name')
  }

  has_one :review
  belongs_to :rater, :class_name => 'User'
  belongs_to :rateable, :polymorphic => true

  #attr_accessible :rate, :dimension

  def author_full_name
    if self.first_name && self.last_name
      "#{self.first_name} #{self.last_name}"
    end
  end

end