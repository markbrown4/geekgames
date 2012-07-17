class AddTotalsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :plays, :integer, :default => 0
    add_index :users, :plays, :order => { :plays => :desc }
    add_index :users, :max_score, :order => { :max_score => :desc }
  end
end
