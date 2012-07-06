class ErrorLog < ActiveRecord::Base
  
  attr_accessible :user_agent, :message, :file, :line
  
  def self.search(search, page)
    paginate :per_page => 100, :page => page,
             :conditions => ['message like ?', "%#{search}%"],
             :order => 'created_at desc'
  end
  
end
