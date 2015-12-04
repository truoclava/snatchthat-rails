class CreateTwilioMessages < ActiveRecord::Migration
  def change
    create_table :twilio_messages do |t|

      t.timestamps null: false
    end
  end
end
