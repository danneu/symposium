class AddRenderedBodyToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :rendered_body, :text
  end
end
