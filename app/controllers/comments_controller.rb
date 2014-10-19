class CommentsController < ApplicationController

  before_filter :authenticate_user!

  load_and_authorize_resource :play
  load_and_authorize_resource :comment, :through => :play

  def create
    @comment.author = current_user
    @comment.save
    respond_with @comment, location: @play
  end

private

  def comment_params
    params.require(:comment).permit :body
  end

end
