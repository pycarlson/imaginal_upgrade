class Rating < ActiveRecord::Base
  
  belongs_to :video
  belongs_to :category 

  before_save :update_video_category

  def update_video_category

    @video = Video.find(self.video_id)
    #@category = Category.find(params[:category_id])
    #@video.ratings << self
    Average.update(self)
    @video.update_overall_video_rating(self)

  end
end