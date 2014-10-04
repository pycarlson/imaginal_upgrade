class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer  :user_id
      t.float    :overall_rating, :default => 0
      t.float    :overall_stars, :default => 0
      t.integer  :overall_votes, :default => 0
      t.string   :facebook_thumbnail_link
      t.string   :title
      t.text     :description
      t.string   :url
      t.string   :link
      t.string   :thumbnail_link
      t.integer  :click_count, :default => 0
      t.boolean  :feature, :default => false

    t.timestamps
    end
  end
end
