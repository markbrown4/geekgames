class Authentication < ActiveRecord::Base
  attr_accessible :provider, :uid, :user_id, :token, :extra
  belongs_to :user
  
  serialize :extra

end
