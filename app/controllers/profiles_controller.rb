class ProfilesController < ApplicationController 

  #before_filter :authenticate

  def show
    @profile = Profile.find(params[:id])

    if current_user && current_user.id == @profile.user.id
      @page_title = "My Videos"
    else
      @page_title = "Videos From " + @profile.user.name
    end

    @video = Video.new
    @videos = @profile.user.videos.order('id DESC').page params[:page]
  end

  private

  def profile_params
    #params.require(:profile).permit(:full_name, :blurb)
  end

  def authenticate
    #redirect_to '/' unless current_user && (current_user.profile == Profile.find(params[:id]))
  end

end