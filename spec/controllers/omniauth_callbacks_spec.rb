# require 'spec_helper'
#
# describe Users::OmniauthCallbacksController do
#
#   describe 'with facebook' do
#
#     before do
#       request.env['devise.mapping'] = Devise.mappings[:user]
#       request.env['omniauth.auth']  = OmniAuth.config.mock_auth[:facebook]
#     end
#
#     it 'logs in', :focus do
#       get :facebook
#       response.code.should == '302'
#     end
#
#   end
#
# end
