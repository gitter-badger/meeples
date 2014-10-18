class UsersController < ApplicationController

  load_resource :user, except: %i[ games ]

  def games
    @user = User.find params[:user_id]
    respond_with @user
  end

  def index
    @users = User.all

    respond_with @users
  end

  def show
    respond_with @user
  end

end
