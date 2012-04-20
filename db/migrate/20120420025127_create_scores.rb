class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.references :round
      t.references :game
      
      t.decimal :score

      t.timestamps
    end
  end
end
