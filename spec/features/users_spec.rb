require 'spec_helper'

describe 'Users' do

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
      fill_in_fields 'user', email:                 'user@testing.com',
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
      fill_in_fields 'user', email: 'user@new-email.com'

      click_button 'Update my account'
      should have_content 'Could not update your account!'

      # with current password
      fill_in_fields 'user', current_password: 'password',
                             email:            'user@new-email.com'

      click_button 'Update my account'
      should have_content 'You updated your account successfully, but we need to verify your new email address. Please check your email and click on the confirm link to finalize confirming your new email address.'
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
        should have_content 'Invalid email or password'

        # valid data
        fill_in_fields :user, email: user.email, password: 'password'
        click_button 'Sign in'
        should have_content 'Signed in successfully'
      end

      context 'as an admin' do

        it 'redirects to admin panel' do
          fill_in_fields :user, email: admin.email, password: 'password'
          click_button 'Sign in'

          should_be_on admin_dashboard_path
        end

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

  end

  describe 'signing out' do

    before do
      login_as user
    end

    it 'is linked to' do
      should have_css("a[href='#{ destroy_user_session_path }']")
    end

    it 'can sign out', :js do
      click_link user.email
      find_link('sign out').click
      should have_content 'Signed out successfully'
    end

  end

end
