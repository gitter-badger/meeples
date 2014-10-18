require 'spec_helper'

describe 'Navbar' do

  subject { page }

  let(:admin) { FactoryGirl.create :admin }
  let(:user)  { FactoryGirl.create :user }

  context 'as a guest' do

    before do
      visit root_path
    end

    it 'does not link to the admin' do
      should_not have_css(".navbar a[href='#{ admin_dashboard_path }']")
    end

    it 'links to sign in' do
      should have_css(".navbar a[href='#{ new_user_session_path }']")
    end

  end

  context 'as a user' do

    before do
      login_as user
      visit root_path
    end

    it 'does not link to the admin' do
      should_not have_css(".navbar a[href='#{ admin_dashboard_path }']")
    end

  end

  context 'as an admin' do

    before do
      login_as admin
      visit root_path
    end

    it 'links to the admin' do
      should have_css(".navbar a[href='#{ admin_dashboard_path }']")
    end

  end

end
