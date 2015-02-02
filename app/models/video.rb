class Video < ActiveRecord::Base
  
  belongs_to :user
  has_many :ratings, :dependent => :destroy
  has_many :averages, :dependent => :destroy

  before_create :get_video_attributes

  #before_save :parse_video_url, :get_video_thumbnail_link
  validates :title, :description, :url, :presence => true
  validates :url, :title, uniqueness: true
  validates_length_of :description, :maximum => 250

  acts_as_taggable # Alias for acts_as_taggable_on :tags

  def self.search(query)
    where("lower(title) like ? OR lower(description) like ?", "%#{query.downcase}%", "%#{query.downcase}%")
  end

  def get_average_rating_for_category(id)
    average = Average.find_by_category_id_and_video_id(id, self.id)
    average == nil ? 0 : average.average
  end

  def average_rating
    average_rating = self.overall_rating.round
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
    if self.provider == 'vimeo'
      embed_code = "<iframe src='http://player.vimeo.com/video/#{self.provider_id}?title=0&byline=0&portrait=0' width='900' height='500' frameborder='0' webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>"
    elsif self.provider == 'youtube'
      embed_code = "<iframe width='900' height='500' src='//www.youtube.com/embed/#{self.provider_id}?modestbranding=1&showinfo=0&rel=0&hd=1&controls=1&wmode=opaque' frameborder='0' allowfullscreen></iframe>"
    end
  end

  def thumbnail_old
    if self.provider == 'vimeo'
      thumbnail = "https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?url=https%3A%2F%2Fres.cloudinary.com%2Fdemo%2Fimage%2Fvimeo%2F#{self.provider_id}.jpg&container=focus&resize_w=210&resize_h=140&refresh=2592000"
    elsif self.provider == 'youtube'
      thumbnail = "https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?url=https%3A%2F%2Fimg.youtube.com%2Fvi%2F#{self.provider_id}%2F0.jpg&container=focus&resize_w=210&resize_h=140&refresh=2592000"
    end
  end

  def thumbnail
    if self.provider == 'vimeo'
      thumbnail = "https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?url=https%3A%2F%2Fres.cloudinary.com%2Fdemo%2Fimage%2Fvimeo%2F#{self.provider_id}.jpg&container=focus&resize_h=220&rsize_w=220&refresh=2592000"
    elsif self.provider == 'youtube'
      thumbnail = "https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?url=https%3A%2F%2Fimg.youtube.com%2Fvi%2F#{self.provider_id}%2F0.jpg&container=focus&resize_h=220&resize_w=220&refresh=2592000"
    end
  end

  def facebook_thumbnail
    if self.provider == 'youtube'
      facebook_thumbnail = "http://i1.ytimg.com/vi/#{self.provider_id}/hqdefault.jpg?feature=og"
    else
      facebook_thumbnail = ''
    end

  end

  private

  def get_video_attributes

    require 'open-uri'
    require 'json'

      provider = self.get_video_type(self.url)
      provider_id = self.get_video_id(self.url)

      if provider == 'vimeo'
        result = JSON.parse(open("http://vimeo.com/api/oembed.json?url=http%3A//vimeo.com/#{provider_id}").read)
      elsif provider == 'youtube'
        result = JSON.parse(open("http://www.youtube.com/oembed?url=http%3A//www.youtube.com/watch?v%3D#{provider_id}&format=json").read)
      end

      self.provider = provider
      self.provider_id = provider_id
      self.video_width = result['width']
      self.video_height = result['height']
      self.thumbnail_width = result['thumbnail_width']
      self.thumbnail_height = result['thumbnail_height']

  end

end













