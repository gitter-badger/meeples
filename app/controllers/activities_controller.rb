class ActivitiesController < ApplicationController

  before_action :authenticate_user!

  def index
    @plays = current_user.activity
  end

end
