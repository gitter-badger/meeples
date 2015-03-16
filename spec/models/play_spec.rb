require 'spec_helper'

describe Play do

  describe 'validations' do

    it { should validate(:presence).of :user }
    it { should validate(:presence).of :game }

  end

  describe '#players' do

    let(:user) { create :user }
    let(:play) { create :play, user: user }

    it 'always includes the play creator' do
      play.players.should include(user)
    end

  end

end
