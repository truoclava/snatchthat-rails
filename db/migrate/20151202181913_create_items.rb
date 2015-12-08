class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :url
      t.string :price
      t.string :source_id
      t.string :image_url
      t.timestamps null: false
    end
  end
end
