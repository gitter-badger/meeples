require 'spec_helper'

describe 'Users' do

  include ActionView::RecordIdentifier

  subject { page }

  let(:admin) { FactoryGirl.create :admin }
  let(:user)  { FactoryGirl.create :user }

  describe 'sign up' do

    before do
      visit new_user_registration_path
    end

    it 'creates a new account' do
      # invalid data
      click_button 'Sign up'
      should have_content 'Could not sign up!'

      # valid data
      fill_in_fields 'user', email:                 Faker::Internet.email,
                             username:              Faker::Internet.user_name,
                             password:              'password',
                             password_confirmation: 'password'

      click_button 'Sign up'

      should have_content 'A message with a confirmation link has been sent to your email address.'
    end

  end

  describe 'canceling account' do

    before do
      login_as user
      visit edit_user_registration_path
    end

    it 'links to cancellation with confirmation' do
      should have_css("a[href='#{ user_registration_path }'][data-confirm='Are you sure?'][data-method='delete']")
    end

  end

  describe 'editing account' do

    before do
      login_as user
      visit edit_user_registration_path
    end

    it 'can change email' do
      # without current password
      fill_in_fields 'user', email: Faker::Internet.email

      click_button 'Update my account'
      should have_content 'Could not update your account!'

      # with current password
      fill_in_fields 'user', current_password: 'password',
                             email:            Faker::Internet.email

      click_button 'Update my account'
      should have_content I18n.t('devise.registrations.update_needs_confirmation')
    end

    it 'can change password' do
      # without current password
      fill_in_fields 'user', password:              'new-password',
                             password_confirmation: 'new-password'

      click_button 'Update my account'
      should have_content 'Could not update your account!'

      # with current password
      fill_in_fields 'user', current_password:      'password',
                             password:              'new-password',
                             password_confirmation: 'new-password'

      click_button 'Update my account'
      should have_content 'You updated your account successfully.'
    end

  end

  describe 'signing in' do

    it 'is linked to from the home page' do
      visit root_path
      should have_css("a[href='#{ new_user_session_path }']")
    end

    describe 'with email' do

      before do
        visit new_user_session_path
      end

      it 'can sign in' do
        # invalid data
        click_button 'Sign in'
        should have_content 'Invalid login or password'

        # valid data
        fill_in_fields :user, login: user.email, password: 'password'
        click_button 'Sign in'
        should have_content 'Signed in successfully'
      end

    end

    describe 'with facebook' do

      before do
        visit root_path
      end

      describe 'invalid data' do

        before do
          OmniAuth.config.mock_auth[:facebook] = :invalid
        end

        it 'displays an error' do
          click_link 'Sign in with Facebook'
          should have_content 'Could not authenticate you from Facebook'
        end

      end

      describe 'valid data' do

        before do
          OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new info:     { email: '12345@facebook.com' },
                                                                        provider: 'facebook',
                                                                        uid:      '123545'
        end

        it 'displays a success message' do
          click_link 'Sign in with Facebook'
          should have_content 'Successfully authenticated from Facebook account'
        end

      end

    end

    describe 'with github' do

      before do
        visit root_path
      end

      describe 'invalid data' do

        before do
          OmniAuth.config.mock_auth[:github] = :invalid
        end

        it 'displays an error' do
          click_link 'Sign in with Github'

          should have_content 'Could not authenticate you from GitHub'
        end

      end

      describe 'valid data' do

        before do
          OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new credentials: { expires: false, token: '123ABC' },
                                                                      info:        { email: 'test@github.com' },
                                                                      provider:    'github',
                                                                      uid:         '123545'
        end

        it 'displays a success message' do
          click_link 'Sign in with Github'

          should have_content 'Successfully authenticated from Github account'
        end

      end

    end

  end

  describe 'signing out' do

    before do
      login_as user
    end

    it 'is linked to' do
      should have_css("a[href='#{ destroy_user_session_path }']")
    end

    it 'can sign out', :js do
      click_link user.username
      find_link('sign out').click
      should have_content 'Signed out successfully'
    end

  end

  describe 'listing users' do

    let(:users) { User.all }
    let(:games) { create_list :game, 2 }

    before do
      create_list :user, 2

      users.each do |user|
        create      :friendship, user: user
        create      :play,       user: user, game: games.last
        create_list :play, 2,    user: user, game: games.first
      end

      login_as user
      visit users_path
    end

    it 'includes the username for each user' do
      users.map { |u| should have_content u.username }
    end

    it 'includes the number of friends for each user' do
      users.map { |u| should have_content "#{ u.friends.count }" }
    end

    it 'includes the total number of plays for each user' do
      users.map { |u| should have_content "#{ u.plays.count }" }
    end

    it 'includes the number unique of plays for each user' do
      users.map { |u| should have_content "#{ u.games.uniq.count }" }
    end

    it 'links to the user profile' do
      users.map { |u| should have_css "a[href='#{ user_path u }']" }
    end

    it 'links to the user game history' do
      users.map { |u| should have_css "a[href='#{ user_games_path u }']" }
    end

    it 'does not link to add yourself as a friend' do
      within("##{ dom_id user }") { should_not have_css "a[href='#{ friendships_path friend_id: user }']" }
    end

    context 'username is blank' do

      let(:invalid) { create :user }

      before do
        invalid.update_attribute :username, nil
        visit users_path
      end

      it 'displays the email instead' do
        should have_content invalid.email
      end

    end

    context 'users are not already your friends' do

      let(:others) { User.where 'id != ?', user.id }

      it 'links to add them as a friend' do
        others.each do |friend|
          within("##{ dom_id friend }") { should have_css "a[href='#{ friendships_path friend_id: friend }']" }
        end
      end

    end

    context 'users are already your friends' do

      let(:friend) { User.where('id != ?', user.id).first }

      before do
        create :friendship, user: user, friend: friend

        visit users_path
      end

      it 'does not link to add them as a friend' do
        within("##{ dom_id friend }") { should_not have_css "a[href='#{ friendships_path friend_id: friend }']" }
      end

    end

  end

end
