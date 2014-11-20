ActiveAdmin.register Category do

  permit_params :name, :description, :alternates, :sort_order

  form do |f|
    f.inputs '' do
      f.input :name
      f.input :description
      f.input :alternates
      f.input :sort_order
    end

    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :alternates
      row :sort_order
    end
  end

end
