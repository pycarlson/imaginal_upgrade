class ChangeVideoSmallLinkToThumbnailLink < ActiveRecord::Migration
  def change
    rename_column :videos, :small_link, :thumbnail_link
  end
end
