class AddFieldsToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :sort_order, :integer, default: 0, after: :name
    add_column :categories, :alternates, :text, after: :name
    add_column :categories, :description, :text, after: :name
  end
end
