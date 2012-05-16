class AddLatestPostAtToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :latest_post_at, :date
  end
end
