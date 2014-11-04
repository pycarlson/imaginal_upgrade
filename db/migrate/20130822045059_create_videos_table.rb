class CreateVideosTable < ActiveRecord::Migration
  create_table :videos do |t|
    t.integer  :user_id
    t.string   :title
    t.text     :description
    t.string   :url
    t.string   :link
    t.string   :small_link
    t.boolean  :feature, :default => false

    t.timestamps
  end
end
