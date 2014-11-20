class StaticPagesController < ApplicationController 
  
  def home

    if current_user && cookies[:publish_video] && cookies[:publish_video].blank?
      @video = Video.find_by(temporary_owner: cookies[:publish_video])
      if @video
        @video.user = current_user
        @video.temporary_owner = ''
        if @video.save
          cookies[:publish_video] = ''
          @redirect = video_path(@video) + "?new=true"
        end
      else
        cookies[:publish_video] = ''
      end
    end

    @feature = Video.find_by_feature(true)
    @video = Video.new

    @categories = Category.all.order('sort_order ASC')
    @category_videos = []
    @category_video_ids = []
    @categories.each do |category|
      @items = Category.find(category.id).averages.limit(20).order('average DESC')
      @category_videos[category.id] = @items
      @items.each do |item|
        @category_video_ids[item.video_id] = item.video_id
      end

    end
    @videos_by_id = []
    @videos_merge = Video.find_all_by_id(@category_video_ids)
    @videos_merge.each do |video|
      @videos_by_id[video.id] = video
    end
    render :home
  end

  def about
  end

end