ActiveAdmin.register Video do

  permit_params :user, :title, :description, :url, :feature, :overall_rating, :overall_stars, :overall_votes, :provider, :video_width, :video_height, :thumbnail_width, :thumbnail_height, :plays, :temporary_owner, :tags

  form do |f|
    f.inputs '' do
      f.input :user
      f.input :title
      f.input :description
      f.input :url

      f.input :provider

      f.input :video_width
      f.input :video_height
      f.input :thumbnail_width
      f.input :thumbnail_height

      f.input :overall_rating
      f.input :overall_stars
      f.input :overall_votes

      f.input :plays
      f.input :feature
      f.input :temporary_owner
      #f.input :tags

    end

    f.actions
  end

  show do |video|
    attributes_table do
      row :user
      row :title
      row :description
      row :url

      row :provider

      row :video_width
      row :video_height
      row :thumbnail_width
      row :thumbnail_height

      row :overall_rating
      row :overall_stars
      row :overall_votes

      row :plays

      row :created_at
      row :updated_at

      row :feature
      row :temporary_owner

    end

    panel 'Tags' do
      table_for video.tags do
        column :name
      end
    end
  end

end
