class Category < ActiveRecord::Base
  
  has_many :ratings
  has_many :averages
  
end