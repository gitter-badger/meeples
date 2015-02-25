require 'spec_helper'

describe 'Comments' do

  subject { page }

  let(:user) { FactoryGirl.create :user }

  describe 'commenting on a play' do

    it 'posts a comment' do
      play = FactoryGirl.create :play, user: user

      login_as user
      visit play_path(play)

      fill_in_fields :comment, body: 'This is a very fancy comment.'
      click_button 'Post comment'

      should have_content 'Comment was successfully created.'
      should have_content 'This is a very fancy comment.'

      Comment.last.author.should == user
    end

  end

end
