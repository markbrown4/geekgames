class Round < ActiveRecord::Base
  belongs_to :user
  has_many :scores
  attr_accessible :step, :total_score
  validates_inclusion_of :total_score, :in => 0..300, :message => "can only be between 1 and 300."

  after_create do
    (1..3).each do |i|
      self.scores.create({ :game_id => i })
    end
  end

  def current_score
    self.scores.where('game_id = ?', self.step).last
  end
  
  def rank
    Round.where("total_score > ?", self.total_score).count
  end
  
  def proccess_score(data)
    self.save_score("50")
    
    # events = data.split('*')
    # events.each do |event|
    #   event = event.split('|')
    # end
    
    # Mouse - [ts, penalty, x, y]
    # - sum ts*penalty
    # - validate length > 15ish
    # Shoot - [ts, evil, x, y]
    # - if x > 700
    #   if evil == 1
    #     points++
    # - else
    #   if evil == 0
    #     points--
    #   
    # Pong - [ts, diff, x, y]
    # - if diff < 0 || diff > 80 # missed paddle
    
  end

  def save_score(value)
    value = BigDecimal(value)
    logger.debug "*** #{value}"
    score = current_score
    score.score = value
    if score.save
      logger.debug "*** #{current_score}"
      self.progress(value)
    else
      return nil
    end
  end
  
  def progress(value)
    unless complete?
      if self.step == 3
        self.complete = true
      else
        self.step += 1
      end
      self.total_score += value
      self.save()
    end
  end
  
  # db queries
  scope :today, where("created_at > ?", Time.zone.now.beginning_of_day)
  scope :leaders, order('total_score DESC').limit(10)
  
  def self.top_three_countries
    Round.joins(:user)
      .group('users.country')
      .order('average_rounds_total_score DESC')
      .limit(3)
      .average("rounds.total_score")
  end

end
