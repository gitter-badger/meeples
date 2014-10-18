require 'spec_helper'

describe 'Games' do

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

      it 'should include the name' do
        click_button 'search'
        should have_content 'Glory to Rome'
      end

      it 'should include the year published' do
        click_button 'search'
        should have_content '2005'
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

      it 'should include the name' do
        click_button 'search'
        should have_content 'Glory to Rome'
      end

      it 'should include the year published' do
        click_button 'search'
        should have_content '2005'
      end

    end

  end

end
