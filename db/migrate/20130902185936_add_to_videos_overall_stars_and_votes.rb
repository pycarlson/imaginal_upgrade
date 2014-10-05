class AddToVideosOverallStarsAndVotes < ActiveRecord::Migration
  def change
    add_column :videos, :overall_stars, :float
    add_column :videos, :overall_votes, :integer
  end
end
