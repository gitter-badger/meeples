require 'spec_helper'

describe Game do

  describe 'validations' do

    it { should validate(:presence).of :name }

  end

  describe '#search_bgg!' do

    it 'creates games from bgg', :vcr do
      Game.count.should == 0
      Game.search_bgg! 'glory to rome'
      Game.count.should == 3
    end

  end

end
