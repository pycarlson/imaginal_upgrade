class CreateProfilesTable < ActiveRecord::Migration
  create_table :profiles do |t|
    t.string      :full_name
    t.text        :blurb
    t.belongs_to  :user

    t.timestamps
  end
end
