require 'spec_helper'

describe 'Admin' do

  subject { page }

  let(:admin) { FactoryGirl.create :admin }
  let(:user)  { FactoryGirl.create :user }

  describe 'permissions' do

    let(:path) { admin_dashboard_path }

    it { should_not allow_access.to :guest }
    it { should_not allow_access.to :user  }
    it { should     allow_access.to :admin }

  end

end
