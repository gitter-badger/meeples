require 'spec_helper'

describe 'Friendships' do

  subject { page }

  let(:admin) { FactoryGirl.create :admin }
  let(:user)  { FactoryGirl.create :user }

  describe 'listing friends' do

    let(:friends) { user.friends }

    before do
      create_list :friendship, 2, user: user

      login_as user
      visit friendships_path
    end

    it 'includes list all friends' do
      friends.each { |f| should have_content f.username }
    end

    it 'should have a link to view friend' do
      friends.each { |f| should have_css "a[href='#{ user_path f }']" }
    end

  end

  describe 'adding friends' do

    let!(:friend) { create :user }

    before do
      login_as user
      visit users_path
    end

    it 'adds a friend' do
      click_link 'Add Friend'

      should have_content 'Added Friend'
    end

  end

end
