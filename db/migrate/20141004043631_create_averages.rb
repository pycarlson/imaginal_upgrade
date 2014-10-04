class CreateAverages < ActiveRecord::Migration
  def change
    create_table :averages do |t|
      t.integer  :video_id
      t.integer  :category_id
      t.integer  :total_stars, :integer, :default => 0
      t.float    :total_ratings, :float, :default => 0
      t.float    :average, :float, :default => 0

      t.timestamps
    end
  end
end
