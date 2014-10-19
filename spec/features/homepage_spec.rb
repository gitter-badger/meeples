require 'spec_helper'

describe 'Homepage' do

  include ActionView::Helpers::DateHelper
  include ActionView::RecordIdentifier

  subject { page }

  before do
    visit root_path
  end

  describe 'viewing all plays' do


  end

end
