class Video < ActiveRecord::Base
  
  belongs_to :user
  has_many :ratings, :dependent => :destroy
  has_many :averages, :dependent => :destroy

  before_save :parse_video_url, :get_video_thumbnail_link
  validates :title, :description, :url, :presence => true
  validates :url, :title, uniqueness: true
  validates_length_of :description, :maximum => 250

  def self.search(query)
    where("lower(title) like ? OR lower(description) like ?", "%#{query.downcase}%", "%#{query.downcase}%")
  end

  def get_average_rating_for_category(id)
    average = Average.find_by_category_id_and_video_id(id, self.id)
    average == nil ? 0 : average.average
  end

  def average_rating
    average_rating = Average.find_by_video_id(self.id)
    average_rating == nil ? 0 : average_rating.average
  end


  def update_overall_video_rating(rating)
    self.overall_stars += rating.num_stars 
    self.overall_votes += 1 
    self.overall_rating = self.overall_stars/self.overall_votes
    self.save
  end
  
  private

  def parse_video_url
    if (/vimeo.com/).match(self.url)
      video_id = (/(\d+)($|\/)/.match(self.url)).to_s
      self.link = "<iframe src='http://player.vimeo.com/video/#{video_id}?title=0&byline=0&portrait=0' width='900' height='500' frameborder='0' webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>"
    elsif (/youtube.com/).match(self.url)
      video_id = (/([\w-]{11})/.match(self.url)).to_s
      self.link = "<iframe width='900' height='500' src='//www.youtube.com/embed/#{video_id}?modestbranding=1&showinfo=0&rel=0&hd=1&controls=0&wmode=opaque' frameborder='0' allowfullscreen></iframe>"
    end
  end

  def get_video_thumbnail_link
    if (/vimeo.com/).match(self.url)
      video_id = (/(\d+)($|\/)/.match(self.url)).to_s
      self.thumbnail_link = "https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?url=https%3A%2F%2Fres.cloudinary.com%2Fdemo%2Fimage%2Fvimeo%2F#{video_id}.jpg&container=focus&resize_w=210&resize_h=140&refresh=2592000"
    elsif (/youtube.com/).match(self.url)
      video_id = (/([\w-]{11})/.match(self.url)).to_s
      self.thumbnail_link = "https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?url=https%3A%2F%2Fimg.youtube.com%2Fvi%2F#{video_id}%2F0.jpg&container=focus&resize_w=210&resize_h=140&refresh=2592000"
      self.facebook_thumbnail_link = "http://i1.ytimg.com/vi/#{video_id}/hqdefault.jpg?feature=og"
    end
  end
end













