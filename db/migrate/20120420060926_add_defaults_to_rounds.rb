class AddDefaultsToRounds < ActiveRecord::Migration
  def change
    change_column :rounds, :step, :integer, :default => 1
    change_column :rounds, :total_score, :decimal, :default => 0
    change_column :scores, :score, :decimal, :default => 0
  end
end
