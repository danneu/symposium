class TopicsController < ApplicationController
  authorize_resource

  def show
    @forum = load_forum params[:forum_id]
    @topic = @forum.topics.find params[:id]
    @posts = @topic.posts.by_created_at
    @new_post = current_user.posts.build if current_user
  end

  def new
    @forum = load_forum params[:forum_id]
    @topic = @forum.topics.build
    @first_post = @topic.posts.build
  end

  def create
    @forum = load_forum params[:forum_id]
    @topic = @forum.topics.build params[:topic]
    @topic.creator = current_user
    if @topic.save
      redirect_to [@forum, @topic], notice: "#{@forum.to_singular} created successfully."
    else
      render :new
    end
  end

  def edit
    @forum = load_forum params[:forum_id]
    @topic = @forum.topics.find params[:id]
    @first_post = @topic.posts.first
  end

  def update
    @forum = load_forum params[:forum_id]
    @topic = @forum.topics.find params[:id]
    if @topic.update_attributes params[:topic]
      redirect_to [@forum, @topic], notice: "Topic saved."
    else
      render :edit
    end
  end

  def destroy
    @forum = load_forum params[:forum_id]
    @topic = @forum.topics.find params[:id]
    if @topic.destroy
      redirect_to @forum, notice: "Topic deleted."
    else
      redirect_to [@forum, @topic], alert: "Topic delete failed."
    end
  end

  private
  def load_forum(forum_id)
    Forum.find forum_id
  end
end
