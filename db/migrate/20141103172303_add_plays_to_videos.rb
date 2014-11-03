class AddPlaysToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :plays, :integer, default: 0
  end
end
