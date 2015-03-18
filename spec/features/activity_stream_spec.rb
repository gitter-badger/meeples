require 'spec_helper'

describe 'Activity Stream' do

  subject { page }

  let(:user) { create :user }

  describe 'viewing' do

    context 'as guest' do

      before do
        visit authenticated_root_path
      end

      it 'is not allowed' do
        should_not have_content 'Activity Stream'
      end

    end

    context 'logged in' do

      before do
        login_as user
      end

      describe 'with activity' do

        let(:play) { create :play, user: user }

        before do
          play # create the play
          visit authenticated_root_path
        end

        it 'shows plays' do
          within 'table.plays tbody' do
            should have_content play.game.name
            should have_content user.username
          end
        end

      end

    end

  end

end
