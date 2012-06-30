class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :title
      t.text :description
      t.string :image_url
      t.datetime :end_time
      
      t.timestamps
    end
  end
end
