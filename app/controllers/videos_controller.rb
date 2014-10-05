class VideosController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :update_click_count, only: [:show]
  before_filter :find_video, only: [:edit, :update, :destroy]
  
  def index
    if params[:search]
      @videos = Video.search(params[:search]).order('overall_rating DESC')
    else
      @videos = Video.order('overall_rating DESC')
    end
    @video = Video.new
  end

  def show
    @show_video = Video.find(params[:id])
    @videos = Video.all
    @small_vids = @videos.sample(20)
    @categories = Category.all
    @rating = Rating.new
    @video = Video.new

    @production_quality_average = @show_video.get_average_rating_for_category(1)
    @radical_creativity_average = @show_video.get_average_rating_for_category(2)
    @communal_effort_average = @show_video.get_average_rating_for_category(3)
    @radical_inclusivity_average = @show_video.get_average_rating_for_category(4)
    @civic_responsibility_average = @show_video.get_average_rating_for_category(5)
    @immediacy_average = @show_video.get_average_rating_for_category(6)
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.create(video_params)
    @video.user = current_user
    if @video.save
      redirect_to @video
    else
      flash[:alert] = "Due to the following your video has not been saved: #{@video.errors.full_messages.join(", ")}. Please try again."
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    if @video.update_attributes(video_params)
      redirect_to video_path(@video)
    else
      render :edit
    end
  end

  def destroy
    @video.destroy
    redirect_to :back
  end

  private

  def video_params
    params.require(:video).permit(:link, :title, :url, :description, :feature)
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