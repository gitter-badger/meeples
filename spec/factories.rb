FactoryGirl.define do

  factory :game do
    name { Faker::Company.name }

    factory :published_game do
      year_published 2014
    end
  end

  factory :play do
    transient do
      with_players 0
    end

    game
    user

    before :create do |play, proxy|
      play.players = create_list :user, proxy.with_players if proxy.with_players.present?
    end

    factory :described_play do
      description { Faker::Company.bs }
    end
  end

  factory :unconfirmed_user, class: User do
    email                 { Faker::Internet.email }
    username              { Faker::Internet.user_name }

    password              'password'
    password_confirmation 'password'

    factory :user, aliases: %i[ friend ] do
      after(:create) { |user, _proxy| user.confirm! }

      factory :admin do
        after(:create) { |user| user.update_attribute :admin, true }
      end
    end

  end

  factory :friendship do
    friend
    user
  end

end
