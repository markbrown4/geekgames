class Prize < ActiveRecord::Base
  belongs_to :deal
  attr_accessible :title, :sub_title, :url, :price, :reduced_price, :position
  
  default_scope :order => 'position ASC'
end
