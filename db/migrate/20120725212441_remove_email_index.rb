class RemoveEmailIndex < ActiveRecord::Migration
  def up
    remove_index(:users, :name => "index_users_on_email")
  end
end
