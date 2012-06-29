class MakeScoresFloats < ActiveRecord::Migration
  def up
    change_column :rounds, :total_score, :float, :default => 0
    change_column :scores, :score, :float, :default => 0
    add_column :scores, :data, :text
  end
end
