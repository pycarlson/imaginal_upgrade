class AddMetaToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :provider, :string
    add_column :videos, :provider_id, :string
    add_column :videos, :video_width, :integer
    add_column :videos, :video_height, :integer
    add_column :videos, :thumbnail_width, :integer
    add_column :videos, :thumbnail_height, :integer
  end
end
