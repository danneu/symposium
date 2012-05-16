class AddPostsCountToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :posts_count, :integer, default: 0
  end
end
