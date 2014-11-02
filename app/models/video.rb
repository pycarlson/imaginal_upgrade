class Video < ActiveRecord::Base
  
  belongs_to :user
  has_many :ratings, :dependent => :destroy
  has_many :averages, :dependent => :destroy

  #before_save :parse_video_url, :get_video_thumbnail_link
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
    average_rating = self.overall_rating
  end

  def update_overall_video_rating(rating)
    self.overall_stars += rating.num_stars 
    self.overall_votes += 1 
    self.overall_rating = self.overall_stars/self.overall_votes
    self.save
  end

  def get_video_type(url)
    if (/vimeo.com/).match(url)
      get_video_type = 'vimeo'
     elsif (/youtube.com/).match(url)
       get_video_type = 'youtube'
    end
  end

  def get_video_id(url)
    if (/vimeo.com/).match(url)
      get_video_id = (/(\d+)($|\/)/.match(self.url)).to_s
    elsif (/youtube.com/).match(url)
      get_video_id = (/([\w-]{11})/.match(self.url)).to_s
    end
  end

  def embed_code

    video_type = self.get_video_type(self.url)
    video_id = self.get_video_id(self.url)

    if video_type == 'vimeo'
      embed_code = "<iframe src='http://player.vimeo.com/video/#{video_id}?title=0&byline=0&portrait=0' width='900' height='500' frameborder='0' webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>"
    elsif video_type == 'youtube'
      embed_code = "<iframe width='900' height='500' src='//www.youtube.com/embed/#{video_id}?modestbranding=1&showinfo=0&rel=0&hd=1&controls=0&wmode=opaque' frameborder='0' allowfullscreen></iframe>"
    end
  end

  def thumbnail

    video_type = self.get_video_type(self.url)
    video_id = self.get_video_id(self.url)

    if video_type == 'vimeo'
      thumbnail = "https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?url=https%3A%2F%2Fres.cloudinary.com%2Fdemo%2Fimage%2Fvimeo%2F#{video_id}.jpg&container=focus&resize_w=210&resize_h=140&refresh=2592000"
    elsif video_type == 'youtube'
      thumbnail = "https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?url=https%3A%2F%2Fimg.youtube.com%2Fvi%2F#{video_id}%2F0.jpg&container=focus&resize_w=210&resize_h=140&refresh=2592000"
    end

  end

  def facebook_thumbnail

    video_type = self.get_video_type(self.url)
    video_id = self.get_video_id(self.url)

    if video_type == 'youtube'
      facebook_thumbnail = "http://i1.ytimg.com/vi/#{video_id}/hqdefault.jpg?feature=og"
    else
      facebook_thumbnail = ''
    end

  end
end













