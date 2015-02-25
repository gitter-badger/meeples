require 'spec_helper'

describe Game do

  describe 'validations' do

    it { should validate(:presence).of :name }

  end

  describe '#search_bgg!' do

    it 'creates games from bgg', :vcr do
      described_class.count.should == 0
      described_class.search_bgg! 'glory to rome'
      described_class.count.should == 3
    end

  end

end
