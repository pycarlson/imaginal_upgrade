class RatingsController < ApplicationController 

  before_filter :do_the_add
  
  def add_rating
  end

  private

  def rating_params
    params.require(:rating).permit(:num_stars, :category_id, :video_id, :ip_address)
  end

  def do_the_add
    previous_rating_found = Rating.find_by_ip_address_and_video_id_and_category_id(request.remote_ip, params[:video_id], params[:category_id])
    if previous_rating_found
      redirect_to video_path(params[:video_id])
    else
      rating = Rating.new(num_stars: params[:num_stars])
      rating.ip_address = request.remote_ip
      rating.category_id = params[:category_id]
      @video = Video.find(params[:video_id])
      @category = Category.find(params[:category_id])
      if rating.save
        @video.ratings << rating
        Average.update(rating)
        @video.update_overall_video_rating(rating)
        redirect_to video_path(params[:video_id])
      else
        redirect_to root_url
      end 
    end
  end
end

