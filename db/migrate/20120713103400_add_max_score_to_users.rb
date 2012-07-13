class AddMaxScoreToUsers < ActiveRecord::Migration
  def up
    add_column :users, :max_score, :float, :default => 0
    User.all.each do |user|
      best_round = user.best_round
      if best_round.present?
        user.update_attribute('max_score', best_round.total_score)
      end
    end
  end
  
  def down
    drop_column :users, :max_score
  end
end
