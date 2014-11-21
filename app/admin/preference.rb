ActiveAdmin.register Preference do

  permit_params :user_id, :name, :value

  index do
    selectable_column
    column :id
    column :user
    column :name
    column :value
    actions
  end

end
