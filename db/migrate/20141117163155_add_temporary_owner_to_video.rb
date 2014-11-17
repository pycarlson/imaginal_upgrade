class AddTemporaryOwnerToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :temporary_owner, :string, default: ''
  end
end
