ActiveAdmin.register User do

  permit_params :email, :name, :provider, :uid, :admin

  form do |f|
    f.inputs '' do
      f.input :email
      f.input :name
      f.input :provider
      f.input :uid
      f.input :admin
    end

    f.actions
  end

end
