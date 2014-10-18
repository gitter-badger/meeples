class Play < ActiveRecord::Base

  belongs_to :game
  belongs_to :user

  validates :game, presence: true
  validates :user, presence: true

  scope :recent, ->{ limit 15 }

end
