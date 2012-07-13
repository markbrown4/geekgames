class Round < ActiveRecord::Base
  belongs_to :user
  has_many :scores, :dependent => :destroy
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
    Round.where("total_score > ?", self.total_score).count + 1
  end
  
  def process_score(data)
    score = 0
    events = data.split('*')
    event_data = {
      start_time: events.shift().to_i,
      end_time: events.pop().to_i,
      events: events
    }
    
    if step == 1
      score = process_mouse_score(event_data)
    elsif step == 2
      score = process_shoot_score(event_data)
    elsif step == 3
      score = process_pong_score(event_data)
    end
    
    if score < 0
      score = 0
    elsif score > 100
      score = 100
    end
    
    self.save_score(score, data)
  end
  
  def process_mouse_score(data)
    # [ts, penalty, x, y]
    # - sum ts * penalty
    # - validate length > 5
    score = 0
    if data[:events].length > 5
      time = 0
      last_time = data[:start_time]
      data[:events].each do |event|
        event = event.split('|')
        ts = event[0].to_f
        time+= (ts - last_time) * event[1].to_i
        last_time = ts
      end
      time+= data[:end_time] - last_time
      score = (1 - (time.to_f / 20000)) * 100
    end
    
    score
  end
  
  def process_shoot_score(data)
    # [ts, evil, x, y]
    score = 0
    data[:events].each do |event|
      event = event.split('|')
      evil = event[1] == '1'
      if event[2].to_i > 700
        # missed
        if evil
          score -= 10
        else
          score += 0.3
        end
      else
        # shot
        if evil
          score += 1
        else
          score -= 5
        end
      end
    end
    
    score
  end
  
  def process_pong_score(data)
    # [ts, diff, x, y]
    # - if diff < 0 || diff > 80 # missed paddle
    score = 0
    data[:events].each do |event|
      event = event.split('|')
      diff = event[1].to_i
      if (diff > -1 && diff < 81)
        score += 2
      end
    end
    
    score
  end

  def save_score(value, data)
    score = current_score
    score.score = value
    score.data = data
    if score.save
      self.progress(value)
    end
  end
  
  def progress(value)
    unless complete?
      self.total_score += value
      if self.step == 3
        self.complete = true
      else
        self.step += 1
      end
      self.save()
    end
  end
  
  # db queries
  scope :today, where("created_at > ?", Time.zone.now.beginning_of_day)
  
  def self.top_three_countries
    Round.joins(:user)
      .group('users.country')
      .order('average_rounds_total_score DESC')
      .limit(3)
      .average("rounds.total_score")
  end

end
