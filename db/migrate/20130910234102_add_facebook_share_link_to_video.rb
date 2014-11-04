class AddFacebookShareLinkToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :facebook_thumbnail_link, :string
  end
end
