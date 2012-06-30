module ApplicationHelper
  
  def menu
    @menu || ''
  end
  
  def time_until(time)
    distance_of_time_in_words(Time.now, time, false, :only => ["minutes", "hours"])
  end
  
end
