require 'spec_helper'

describe 'My Recent Plays' do

  subject { page }

  let(:player) { create :user }

  before do
    Timecop.scale(5000) { create_list :play, 20, user: player }
    visit user_path player
  end

  it 'includes 15 plays' do
    all('.play').count.should == 15
  end

  it 'it sorts plays reverse cronologically' do
    names = Play.where(user: player).limit(15).order('plays.created_at desc').joins(:game).pluck 'games.name'
    text.should =~ /#{ names.join '.+' }/m
  end

  it 'includes the name of each game' do
    player.plays.recent.map { |p| should have_content p.game.name }
  end

end
