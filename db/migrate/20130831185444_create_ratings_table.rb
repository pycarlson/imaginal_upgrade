class CreateRatingsTable < ActiveRecord::Migration
  create_table :ratings do |t|
    t.belongs_to  :video
    t.belongs_to  :category
    t.integer     :num_stars
    t.string      :ip_address

    t.timestamps
  end
end
