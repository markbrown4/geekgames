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

  def current_score
    self.scores.where('game_id = ?', step).last
  end

  def incomplete
    complete == false
  end

  def save_score(value)
    value = BigDecimal(value)
    score = current_score
    score.score = value
    if score.save
      self.progress(value)
    else
      return nil
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
