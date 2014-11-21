class CreatePreferencesTable < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.integer  :user_id
      t.string   :name
      t.string   :value
    end
  end
end
