class Average < ActiveRecord::Base

  belongs_to  :video
  belongs_to  :category

  def self.update(rating)
    avg = Average.find_or_create_by_video_id_and_category_id(rating.video_id, rating.category_id)
    avg.total_stars += rating.num_stars
    avg.total_ratings += 1
    avg.average = (avg.total_stars/avg.total_ratings)
    avg.save

    category = Category.find(rating.category_id)
    category.averages << avg

    video = Video.find(rating.video_id)
    video.averages << avg
  end

end

 