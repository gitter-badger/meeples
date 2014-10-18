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

  devise :omniauthable, omniauth_providers: %i[ facebook ]

  scope :admin,           ->{ where admin: true }
  scope :access_locked,   ->{ where 'locked_at IS NOT NULL AND locked_at >= ?', unlock_in.ago }
  scope :access_unlocked, ->{ where 'locked_at IS NULL OR locked_at < ?',       unlock_in.ago }

  def self.from_omniauth auth
    password = Devise.friendly_token[0,20]

    user = where(provider: auth.provider, uid: auth.uid).first_or_create do |u|
      u.email                 = auth.info.email
      u.password              = password
      u.password_confirmation = password
    end

    user.confirm!
    user
  end

  def self.new_with_session params, session
    super.tap do |user|
      if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
        user.email ||= data['email']
      end
    end
  end

  def locked?
    access_locked? ? true : false
  end

  def unlocked?
    not locked?
  end

end
