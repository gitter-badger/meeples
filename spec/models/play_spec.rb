require 'spec_helper'

describe Play do

  describe 'validations' do

    it { should validate(:presence).of :user }
    it { should validate(:presence).of :game }

  end

end
