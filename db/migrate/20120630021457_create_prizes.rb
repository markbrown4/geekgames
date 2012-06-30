class CreatePrizes < ActiveRecord::Migration
  def change
    create_table :prizes do |t|
      t.string :title
      t.string :sub_title
      t.string :url
      t.decimal :price, :precision => 8, :scale => 2
      t.decimal :reduced_price, :precision => 8, :scale => 2
      t.references :deal

      t.timestamps
    end
    add_index :prizes, :deal_id
  end
end
