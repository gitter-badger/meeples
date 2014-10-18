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
      should have_content play.user.username
    end

  end

  describe 'viewing all the games played by a user' do

    let(:player) { create :user }
    let(:plays)  { player.plays }

    before do
      Timecop.scale(1000) { create_list :described_play, 10, user: player }
      10.times { create :play, user: player, game: Game.offset(rand Game.count).limit(1).first }

      Timecop.freeze

      visit user_games_path player
    end

    it 'includes played games' do
      all('.game').count.should == player.played_games.count
    end

  end


end
