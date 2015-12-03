class CreatePriceChecks < ActiveRecord::Migration
  def change
    create_table :price_checks do |t|

      t.timestamps null: false
    end
  end
end
