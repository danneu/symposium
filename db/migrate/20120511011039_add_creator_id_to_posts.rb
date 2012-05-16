class AddCreatorIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :creator_id, :integer
  end
end
