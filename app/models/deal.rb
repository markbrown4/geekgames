class Deal < ActiveRecord::Base
  has_many :prizes, :dependent => :destroy
  attr_accessible :title, :description, :image_url

  default_scope do
    order("end_time ASC")
  end
  
  def time_from_now
    distance_of_time_in_words(Time.now, end_time)
    
    # diff = Time.now() - self.end_time.time
    #     "#{diff.hour.to_s} hours, #{diff.min.to_s} minutes"
  end
  
  def self.current
    order("end_time ASC").where("end_time > ?", Time.zone.now).first
  end
end
