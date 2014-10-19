require 'spec_helper'

describe 'Comments' do

  subject { page }

  let(:user) { FactoryGirl.create :user }

  describe 'commenting on a friends play' do

    it 'should post a comment' do
      friend = FactoryGirl.create :user
      play   = FactoryGirl.create :play, user: user

      FactoryGirl.create :friendship, user: user, friend: friend

      login_as user
      visit play_path(play)

      fill_in_fields :comment, body: 'This is a very fancy comment.'
      click_button 'Post comment'

      should have_content 'Comment was successfully created.'
      should have_content 'This is a very fancy comment.'

      Comment.last.author.should == user
    end

    it 'should display author name'
    it 'should display time posted'
    it 'should not post a comment to a non-friend'

  end

end
