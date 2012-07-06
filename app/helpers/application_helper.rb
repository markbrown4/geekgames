module ApplicationHelper
  
  def menu
    @menu || ''
  end
  
  def time_until(time)
    distance_of_time_in_words(Time.now, time, false, :only => ["minutes", "hours"])
  end
  
  def country_selector(form)
    form.country_code_select :country, {
      'Australia' => 'AU',
      'United States' => 'US',
      'United Kingdom' => 'UK',
      'India' => 'IN',
      'Germany' => 'DE'
    }
  end
    
end
