class Page < ActiveRecord::Base
  
  attr_accessible :body, :slug, :title
  validates :slug, :uniqueness => true
  
end
