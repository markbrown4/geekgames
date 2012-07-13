class AddPositionToPrizes < ActiveRecord::Migration
  def change
    add_column :prizes, :position, :integer, :default => 0
  end
end
