class UsersController < ApplicationController

  load_resource :user

  def show
    respond_with @user
  end

end
