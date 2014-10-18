require 'spec_helper'

describe 'Friendships' do

  subject { page }

  let(:admin) { FactoryGirl.create :admin }
  let(:user)  { FactoryGirl.create :user }

  describe 'listing friends' do

    before do
      login_as user

      friend_a = FactoryGirl.create :user, email: 'friend_a@example.com'
      friend_b = FactoryGirl.create :user, email: 'friend_b@example.com'

      non_friend = FactoryGirl.create :user, email: 'non_friend@example.com'

      FactoryGirl.create :friendship, user: user, friend: friend_a
      FactoryGirl.create :friendship, user: user, friend: friend_b
    end

    it 'should have a link to view friends' do
      should have_css("a[href='#{ friendships_path }']")
    end

    it 'should list friends' do
      visit friendships_path

      should have_content 'friend_a@example.com'
      should have_content 'friend_b@example.com'

      should_not have_content 'non_friend@example.com'
    end

  end

  describe 'adding friends' do

    before do
      FactoryGirl.create :user

      login_as user
      visit users_path
    end

    context 'add friend links' do
      it 'should not show a link for current user'

      it 'should not show a link for current friends'
    end

    it 'should add a friend' do
      click_link 'Add Friend'

      should have_content 'Added Friend'
    end

  end

end
