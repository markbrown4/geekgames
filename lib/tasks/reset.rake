namespace :scores do
  desc 'Reset all scores back to zero'
  task :reset => :environment do
    Round.delete_all
    Score.delete_all
    User.update_all(:max_score => 0, :plays => 0)
  end
end