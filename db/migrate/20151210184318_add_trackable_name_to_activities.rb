class AddTrackableNameToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :trackable_name, :string
  end
end
