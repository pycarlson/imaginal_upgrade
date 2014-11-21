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

    @page_title = "Videos tagged by " + params[:id]

    @tag_name = params[:id]

    @tag = Tag.find_by_name(@tag_name)

    if @tag
      @videos = Video.tagged_with(@tag_name).order('id DESC').page params[:page]
    else
      @videos = []
    end
    @video = Video.new

  end

end