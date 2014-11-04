class RemoveColumnsFromVideos < ActiveRecord::Migration
  def change
    remove_column :videos, :link, :string
    remove_column :videos, :link, :string
    remove_column :videos, :thumbnail_link, :string
    remove_column :videos, :facebook_thumbnail_link, :string
  end
end
