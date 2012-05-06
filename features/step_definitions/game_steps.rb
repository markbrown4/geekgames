Given /^these rounds$/ do |table|
  table.hashes.each do |row|
    user = User.make!(:username => row[:username], :country => row[:country])
    
    round = user.rounds.new()
    round.created_at = row[:date] || Date.today
    round.save
    
    round.save_score(row[:score1])
    round.save_score(row[:score2])
    round.save_score(row[:score3])
  end
end
