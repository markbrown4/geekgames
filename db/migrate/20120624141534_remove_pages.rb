class RemovePages < ActiveRecord::Migration
  def up
    Page.find_by_slug('privacy').try(:delete)
    Page.find_by_slug('rules').try(:delete)
  end

  def down
  end
end
