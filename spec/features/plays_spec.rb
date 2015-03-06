require 'spec_helper'

describe 'Plays' do

  include ActionView::Helpers::DateHelper
  include ActionView::Helpers::TextHelper
  include ActionView::RecordIdentifier

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
        click_button 'Add Play'
        should have_content 'Play was successfully created'
      end

      describe 'adding players' do

        let(:player) { create :user }

        before do
          fill_in_fields :play, user_usernames: player.username
          click_button 'Add Play'
        end

        it 'shows success message' do
          should have_content 'Play was successfully created'
        end

        it 'shows number of players added' do
          should have_content 'Playing with 1 player'
          should have_content player.username
        end

        it 'autocompletes usernames', :js

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

    context 'with players' do

      let(:player) { create :user }

      before do
        play.player_ids = [player.id]
        visit play_path play
      end

      it 'includes player username' do
        should have_content player.username
      end

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
      all('.game').count.should == player.games.uniq.count
    end

    it 'includes number of times each game was played' do
      player.played_games.map do |game|
        count = player.plays.where(game: game).count
        within("##{ dom_id game }") { should have_content count.to_s }
      end
    end

    it 'includes the time since first playing each game' do
      player.played_games.map do |game|
        play = player.plays.where(game: game).last
        within("##{ dom_id game }") { should have_content time_ago_in_words(play.created_at) }
      end
    end

    it 'includes the time since last playing each game' do
      player.played_games.map do |game|
        play = player.plays.where(game: game).first
        within("##{ dom_id game }") { should have_content time_ago_in_words(play.created_at) }
      end
    end

    it 'sorts games reverse cronologically by play date' do
      names = player.played_games.map &:name
      text.should =~ /#{ names.join '.+' }/m
    end

    after do
      Timecop.return
    end

  end

  describe 'viewing all plays' do

    let(:plays) { Play.limit 15 }

    before do
      Timecop.scale(-50_000) { create_list :play, 3, with_players: 2 }
      visit plays_path
    end

    it 'includes username for all plays' do
      plays.map { |p| within("##{ dom_id p }") { should have_content p.user.username } }
    end

    it 'includes number of players for all plays' do
      plays.map { |p| within("##{ dom_id p }") { should have_content "#{ p.players.count }" } }
    end

    it 'includes times for all plays' do
      plays.map { |p| within("##{ dom_id p }") { should have_content time_ago_in_words(p.created_at) } }
    end

    it 'it sorts plays reverse cronologically' do
      names = Play.order('created_at desc').map { |p| p.game.name }
      text.should =~ /#{ names.join '.+' }/m
    end

  end

end
