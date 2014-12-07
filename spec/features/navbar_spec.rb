require 'spec_helper'

describe 'Navbar' do

  subject { page }

  let(:admin) { FactoryGirl.create :admin }
  let(:user)  { FactoryGirl.create :user }

  context 'as a guest' do

    before do
      visit root_path
    end

    it 'links to sign in' do
      should have_css(".navbar a[href='#{ new_user_session_path }']")
    end

    it { should have_css "a[href='#{ games_path }']" }
    it { should have_css "a[href='#{ plays_path }']" }
    it { should have_css "a[href='#{ users_path }']" }

  end

  context 'as a user' do

    before do
      login_as user
      visit root_path
    end

    it { should have_css "a[href='#{ user_path user }']" }
    it { should have_css "a[href='#{ user_games_path user }']" }

  end

end
