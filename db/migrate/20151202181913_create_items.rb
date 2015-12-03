class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :url
      t.integer :price
      t.integer :source_id
      t.timestamps null: false
    end
  end
end
