class ChangeProfilesTable < ActiveRecord::Migration
  def self.up
    change_column :profiles, :blurb, :text
  end

  def self.down
    change_column :profiles, :blurb, :string
  end
end
