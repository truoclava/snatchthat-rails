class CreateTwis < ActiveRecord::Migration
  def change
    create_table :twis do |t|

      t.timestamps null: false
    end
  end
end
