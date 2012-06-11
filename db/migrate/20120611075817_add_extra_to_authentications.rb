class AddExtraToAuthentications < ActiveRecord::Migration
  def change
    add_column :authentications, :extra, :text
  end
end
