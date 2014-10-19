class User < ActiveRecord::Base

  # Include default devise modules. Others available are: :token_authenticatable, :lockable, & :timeoutable
  devise :confirmable,
         :database_authenticatable,
         :lockable,
         :recoverable,
         :registerable,
         :rememberable,
         :trackable,
         :validatable

  devise :omniauthable, omniauth_providers: %i[ facebook github ]

  has_many :friends,      :through => :friendships
  has_many :friendships
  has_many :games,                                       :through => :plays
  has_many :plays,        -> { order 'plays.created_at desc' }

  validates :username, presence: true, uniqueness: { case_sensitive: false }

  scope :access_locked,   ->{ where 'locked_at IS NOT NULL AND locked_at >= ?', unlock_in.ago }
  scope :access_unlocked, ->{ where 'locked_at IS NULL OR locked_at < ?',       unlock_in.ago }
  scope :admin,           ->{ where admin: true }

  attr_accessor :login

  # Devise find for authentication override
  # used to allow authentication via email or username
  def self.find_for_database_authentication warden_conditions
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    query = where(conditions)
    if login
      query.where('lower(username) = :login OR lower(email) = :login', { login: login.downcase }).first
    else
      query.first
    end
  end

  def self.from_omniauth auth
    password = Devise.friendly_token[0,20]
    info = auth.info
    email = info.email

    user = where(provider: auth.provider, uid: auth.uid).first_or_create do |u|
      u.username              = info.nickname.blank? ? email : info.nickname
      u.email                 = email.blank? ? "#{u.username}@meepl.es" : email
      u.password              = password
      u.password_confirmation = password
    end

    user.skip_confirmation!
    user
  end

  def self.new_with_session params, session
    super.tap do |user|
      Rails.logger.error "#new_with_session: #{user.inspect}"
      if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
        user.email ||= data['email']
      end
    end
  end

  def played_games
    Game.played_by id
  end

  def locked?
    access_locked? ? true : false
  end

  def unlocked?
    not locked?
  end

end
