class Deal < ActiveRecord::Base
  has_many :prizes
  attr_accessible :title, :description, :image_url
  
  def time_from_now
    distance_of_time_in_words(Time.now, end_time)
    
    # diff = Time.now() - self.end_time.time
    #     "#{diff.hour.to_s} hours, #{diff.min.to_s} minutes"
  end
  
  def self.todays
    where("DATE(created_at) = DATE(?)", Time.now).limit(1).first
  end
end
