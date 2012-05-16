class ChangeTopicLatestPostAtFromDateToDatetime < ActiveRecord::Migration
  def change
    change_column :topics, :latest_post_at, :datetime
  end
end
