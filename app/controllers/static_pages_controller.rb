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

    # first we get the average items
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

    # then we get all the videos for those IDs
    @videos_by_id = []
    @videos = Video.find_all_by_id(@category_video_ids)
    @videos.each do |video|
      @videos_by_id[video.id] = video
    end

    # now we sort the videos back in by category so they're ready for our carousel
    @carousel_videos = []
    @categories.each do |category|
      @items = @category_videos[category.id]
      @videos = []
      @items.each do |item|
        @videos.push(@videos_by_id[item.video_id])
      end
      @carousel_videos[category.id] = @videos
    end

    render :home
  end

  def about
  end

end