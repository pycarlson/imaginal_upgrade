module RatingsHelper
  def Rating.previous_rating_found?(video_id, category_id, ip_address)
    rating = Rating.find_by_ip_address_and_video_id_and_category_id(ip_address, video_id, category_id)
    rating ? true : false
  end
end