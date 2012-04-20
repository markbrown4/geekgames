class Round < ActiveRecord::Base
  
  has_many :scores
  
  attr_accessible :step, :total_score
  
  after_create do
    (1..3).each do |i|
      self.scores.create({ :game_id => i })
    end
  end
end
