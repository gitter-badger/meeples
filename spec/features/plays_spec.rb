require 'spec_helper'

describe 'Plays' do

  include ActionView::Helpers::DateHelper

  subject { page }

  describe 'recording a play' do

    let(:game)   { create :published_game }
    let(:player) { create :user }

    context 'not logged in' do

      before do
        visit new_game_play_path game
      end

      it { should_be_on new_user_session_path }

    end

    context 'when logged in' do

      before do
        login_as player
        visit new_game_play_path game
      end

      it 'records a play' do
        # valid data
        click_button 'play'
        should have_content 'Play was successfully created'
      end

    end

  end

  describe 'viewing a play' do

    let(:play) { create :play }

    before do
      visit play_path play
    end

    it 'includes game name' do
      should have_content play.game.name
    end

    it 'includes play time' do
      should have_content time_ago_in_words(play.created_at)
    end

    it 'includes user' do
      should have_content play.user.display_name
    end

  end

end
