class SetDefaultToVideosTableAverages < ActiveRecord::Migration
  def change
    change_column :videos, :overall_rating, :float, :default => 0
    change_column :videos, :overall_stars, :float, :default => 0
    change_column :videos, :overall_votes, :integer, :default => 0
  end
end
