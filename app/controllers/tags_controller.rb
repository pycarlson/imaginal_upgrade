class TagsController < ApplicationController

  def show
    @tag = Tag.find_by_name(params[:id])
    @video = Video.new
    @videos = Video.tagged_with(@tag.name).order('id DESC').page params[:page]
  end

end