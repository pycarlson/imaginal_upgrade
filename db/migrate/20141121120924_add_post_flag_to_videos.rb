class AddPostFlagToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :post_to_facebook, :boolean
  end
end
