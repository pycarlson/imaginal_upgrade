class VideosController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show, :create]
  before_filter :update_click_count, only: [:show]
  before_filter :find_video, only: [:edit, :update, :destroy]
  
  def index
    if params[:search]
      @videos = Video.search(params[:search]).where(temporary_owner: '').order('overall_rating DESC').page params[:page]
    else
      @videos  = Video.where(temporary_owner: '').order('overall_rating DESC').page params[:page]
    end
    @video = Video.new
  end

  def show

    @show_video = Video.find_by(temporary_owner: '', id: params[:id])

    if @show_video

      @show_video.update_attribute(:plays, @show_video.plays + 1)
      #@show_video_user = User.find(@show_video.user_id)
      @videos = Video.all

      @small_vids = @videos.sample(20)
      @categories = Category.all.order('sort_order ASC')
      @rating = Rating.new
      @video = Video.new


      @category_averages = []

      @categories.each do |category|
        @category_averages[category.id] = @show_video.get_average_rating_for_category(category.id)
      end

    else
      redirect_to videos_path
    end
  end

  def new
    redirect_to videos_path
  end

  def create

    @video = Video.create(video_params)

    if current_user
     @video.user = current_user
    else
     random_string = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
     @video.temporary_owner = random_string
     cookies[:publish_video] = random_string
    end

    if @video.save
      flash[:new] = 'true'

      if current_user
        redirect_to video_path(@video)
      else
        redirect_to user_omniauth_authorize_path(:facebook)
      end

    else
      flash[:alert] = "Due to the following your video has not been saved: #{@video.errors.full_messages.join(", ")}. Please try again."
      redirect_to root_path
    end
  end

  def edit
    redirect_to videos_path
  end

  def update
    if @video.update_attributes(video_params)
      redirect_to "/videos/#{@video.id}/#{@video.title.parameterize}" #not sure why video_path doesn't use the helper method we overloaded
    else
      render :edit
    end
  end

  def destroy
    @video.destroy
    flash[:notice] = "Video deleted."
    redirect_to root_path
  end

  private

  def video_params
    params.require(:video).permit(:link, :title, :url, :description, :feature, :tag_list, :post_to_facebook)
  end

  def update_click_count
    @show_video = Video.find(params[:id])
    @show_video.click_count += 1
    @show_video.save
  end

  def find_video
    @video = Video.find(params[:id])
  end

end