class CreateAveragesTable < ActiveRecord::Migration
  create_table :averages do |t|
    t.integer  :video_id
    t.integer  :category_id
    t.integer  :total_stars
    t.float    :total_ratings
    t.float    :average

    t.timestamps
  end
end
