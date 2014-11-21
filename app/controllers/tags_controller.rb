class TagsController < ApplicationController

  def show

    #me = FbGraph::User.me(current_user.access_token)
    #me.feed!(
    #    :message => 'Updating via FbGraph',
    #    :picture => 'https://graph.facebook.com/matake/picture',
    #    :link => 'https://github.com/nov/fb_graph',
    #    :name => 'FbGraph',
    #    :description => 'A Ruby wrapper for Facebook Graph API'
    #)

    @tag = Tag.find_by_name(params[:id])
    @video = Video.new
    @videos = Video.tagged_with(@tag.name).order('id DESC').page params[:page]
  end

end