require 'spec_helper'

describe FactoryGirl do
  described_class.factories.each do |factory|
    describe factory.name.to_s.titleize do
      it 'generates properly' do
        create_list factory.name, 3
      end
    end
  end
end
