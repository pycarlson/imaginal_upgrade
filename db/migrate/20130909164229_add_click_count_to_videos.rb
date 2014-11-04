class AddClickCountToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :click_count, :integer, :default => 0
  end
end
