require 'spec_helper'

describe 'Games' do

  include ActionView::Helpers::DateHelper
  include ActionView::RecordIdentifier

  subject { page }

  describe 'searching', :vcr do

    context 'game does not exist in database' do

      before do
        visit games_path
        fill_in_fields search_game_name: 'glory to rome'
      end

      it 'searches bgg' do
        Game.should_receive(:search_bgg!).with('glory to rome').and_call_original
        click_button 'search'
      end

    end

    context 'game already exists in database' do

      let!(:game) { create :game, name: 'Glory to Rome', year_published: 2005 }

      before do
        visit games_path
        fill_in_fields search_game_name: 'glory to rome'
      end

      it 'does not search bgg' do
        click_button 'search'
        Game.should_not_receive :search_bgg!
      end

    end

  end

  describe 'listing' do

    let!(:games) { create_list :published_game, 3 }

    before do
      visit games_path
    end

    it 'includes the name of each game' do
      games.each { |g| should have_content g.name }
    end

    it 'includes the year published for each game' do
      games.each { |g| should have_content g.year_published }
    end

    it 'includes link  to each game' do
      games.each { |g| should have_css "a[href='#{ game_path g }']" }
    end

  end

  describe 'viewing' do

    let(:game) { create :game, name: 'munchkin fu 2' }

    before do
      visit game_path game
    end

    it { should have_css "a[href='#{ games_path }']"}
    it { should have_css "a[href='#{ new_game_play_path game }']"}

    it 'includes the name' do
      should have_content game.name
    end

    it 'includes the year published' do
      should have_content game.year_published
    end

    it 'includes link to stack exchange' do
      should have_css "a[href='#{game.stack_exchange_link}']"
    end

    context 'without plays' do

      it { should_not have_css '.plays' }

    end

    context 'with plays' do

      let!(:plays) { create_list :play, 2, game: game, players: create_list(:user, rand(3)) }

      before do
        visit game_path game
      end

      it { should have_css '.plays' }

      it 'includes username for all plays' do
        plays.map { |p| within("##{ dom_id p }") { should have_content p.user.username } }
      end

      it 'includes number of players for all plays' do
        plays.map { |p| within("##{ dom_id p }") { should have_content "#{ p.players.count }" } }
      end

      it 'includes times for all plays' do
        plays.map { |p| within("##{ dom_id p }") { should have_content time_ago_in_words(p.created_at) } }
      end

    end

  end

end
