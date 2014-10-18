require 'spec_helper'

describe User do

  describe 'defaults' do

    its(:admin) { should be_falsey }

  end

  describe 'validations' do

    it { should validate(:confirmation).of(:password).with :if => :password_required? }

    it { should validate(:presence).of(:email).with :if => :email_required? }
    it { should validate(:presence).of(:password).with :if => :password_required? }

    it { should validate(:uniqueness).of(:email).with allow_blank: true, case_sensitive: true, :if => :email_changed? }

  end

end
