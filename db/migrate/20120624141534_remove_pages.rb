class RemovePages < ActiveRecord::Migration
  def up
    Page.find_by_slug('privacy').delete
    Page.find_by_slug('rules').delete
  end

  def down
  end
end
