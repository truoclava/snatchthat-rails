class CreateClosets < ActiveRecord::Migration
  def change
    create_table :closets do |t|
      t.string :name
      t.integer :board_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
