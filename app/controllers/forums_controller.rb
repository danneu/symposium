class ForumsController < ApplicationController
  def show
    #@forum = Forum.includes(:topics).find params[:id]
    @forum = Forum.find params[:id]
    @topics = @forum.topics.by_latest_post_at
  end
end
