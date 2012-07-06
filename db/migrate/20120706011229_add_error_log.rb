class AddErrorLog < ActiveRecord::Migration
  def change
    create_table :error_logs do |t|
      t.string  :user_agent
      t.string  :message
      t.string  :file
      t.integer :line

      t.timestamps
    end
  end
end
