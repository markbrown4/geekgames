class Score < ActiveRecord::Base
  belongs_to :round
  belongs_to :game
  
  attr_accessible :score, :game_id
  
  validates_inclusion_of :score, :in => 0..100, :message => "can only be between 0 and 100."
  
  default_scope order("game_id")
end
