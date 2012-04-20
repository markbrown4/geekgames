class Score < ActiveRecord::Base
  belongs_to :round
  belongs_to :game
  
  attr_accessible :score, :game_id
end
