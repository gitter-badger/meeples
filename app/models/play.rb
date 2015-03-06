class Play < ActiveRecord::Base

  belongs_to :game
  belongs_to :user

  has_many :comments
  has_many :game_players
  has_many :players,      :through => :game_players, class: User

  validates :game, presence: true
  validates :user, presence: true

  scope :recent, -> { limit 15 }

  after_validation :add_creator_to_players

  attr_reader :user_usernames

  def self.unique_users
    select('distinct user_id').count
  end

  def self.unique_games
    select('distinct game_id').count
  end

  def user_usernames= name_or_names
    usernames = name_or_names.first.split ','
    self.player_ids = User.where(username: usernames).uniq.pluck :id
  end

private

  def add_creator_to_players
    self.players |= [user]
  end

end
