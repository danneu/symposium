class AddCreatorIdToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :creator_id, :integer
  end
end
