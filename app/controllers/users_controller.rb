class UsersController < ApplicationController

  load_resource :user

  def index
    @users = User.all

    respond_with @users
  end

  def show
    respond_with @user
  end

end
