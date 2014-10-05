class AddDefaultToAveragesTable < ActiveRecord::Migration
  def change
    change_column :averages, :average, :float, :default => 0
    change_column :averages, :total_ratings, :float, :default => 0
    change_column :averages, :total_stars, :integer, :default => 0
  end
end
