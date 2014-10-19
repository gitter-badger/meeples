class UsersController < ApplicationController

  load_resource :user, except: %i[ index games ]

  def games
    @user = User.find params[:user_id]
    respond_with @user
  end

  def index
    @users = User.page params[:page]

    respond_with @users
  end

  def show
    respond_with @user
  end

end
