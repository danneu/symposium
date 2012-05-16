class PostsController < ApplicationController
  authorize_resource

  def new
    @post = @topic.posts.build
  end

  def create
    @topic = load_topic params[:topic_id]
    @post = @topic.posts.build params[:post]
    @post.creator = current_user
    if @post.save
      redirect_to [@topic.forum, @topic], notice: "Post successful."
    else
      render :new
    end
  end

  def edit
    @topic = load_topic params[:topic_id]
    @post = @topic.posts.find params[:id]
  end

  def update
    @topic = load_topic params[:topic_id]
    @post = @topic.posts.find params[:id]
    if @post.update_attributes params[:post]
      redirect_to [@topic.forum, @topic], info: "Post saved."
    else
      render :edit
    end
  end

  def destroy
    @topic = load_topic params[:topic_id]
    @post = @topic.posts.find params[:id]
    if @post.destroy
      redirect_to [@topic.forum, @topic], notice: "Post deleted."
    else
      redirect_to [@topic, @post], alert: "Post delete failed."
    end
  end

  private
  def load_topic(topic_id)
    Topic.find topic_id
  end
end
