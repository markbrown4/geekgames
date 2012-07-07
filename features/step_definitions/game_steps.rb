Given /^these rounds$/ do |table|
  table.hashes.each do |row|
    user = User.make!(:username => row[:username], :country => row[:country])
    
    round = user.rounds.new()
    round.created_at = row[:date] || Date.today
    round.save
    
    round.save_score(row[:score1].to_f, "")
    round.save_score(row[:score2].to_f, "")
    round.save_score(row[:score3].to_f, "")
  end
end

Given /^the games exist$/ do
    Game.find(1) || Game.make!(:id => 1)
    Game.find(2) || Game.make!(:id => 2)
    Game.find(3) || Game.make!(:id => 3)
end
