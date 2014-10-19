FactoryGirl.define do

  factory :game do
    name { Faker::Company.name }

    factory :published_game do
      year_published 2014
    end
  end

  factory :play do
    game
    user

    factory :described_play do
      description { Faker::Company.bs }
    end
  end

  factory :unconfirmed_user, class: User do
    sequence(:email) { |n| "user#{ n }@testing.com" }

    username              { Faker::Internet.user_name }
    password              'password'
    password_confirmation 'password'

    factory :user, aliases: %i[ friend ] do
      after(:create) { |user, proxy| user.confirm! }

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
