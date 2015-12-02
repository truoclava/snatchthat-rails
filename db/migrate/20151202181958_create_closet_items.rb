class CreateClosetItems < ActiveRecord::Migration
  def change
    create_table :closet_items do |t|
      t.integer :closet_id
      t.integer :item_id

      t.timestamps null: false
    end
  end
end
