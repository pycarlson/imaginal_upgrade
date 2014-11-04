class CreateCategoriesTable < ActiveRecord::Migration
  create_table :categories do |t|
    t.string :name

    t.timestamps
  end
end
