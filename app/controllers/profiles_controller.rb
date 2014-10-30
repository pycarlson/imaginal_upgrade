class ProfilesController < ApplicationController 

  before_filter :authenticate

  def show
    #@profile = Profile.find(params[:id])
    #@user = User.find(1)
    @video = Video.new
    #@categories = Category.all
    @videos = current_user.videos.order('id DESC').page params[:page]
    #@rating = Rating.new
  end

private

  private

  def profile_params
    params.require(:profile).permit(:full_name, :blurb)
  end

  def authenticate
    redirect_to '/' unless current_user && (current_user.profile == Profile.find(params[:id]))
  end

end