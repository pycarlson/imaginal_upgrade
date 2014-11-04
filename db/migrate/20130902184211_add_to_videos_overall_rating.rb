class AddToVideosOverallRating < ActiveRecord::Migration
  def change
    add_column :videos, :overall_rating, :float
  end
end
