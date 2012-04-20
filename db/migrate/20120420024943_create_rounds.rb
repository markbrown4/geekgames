class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.references :user
      t.decimal :total_score
      t.integer :step

      t.timestamps
    end
  end
end
