class AddTrackableSourceToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :trackable_source, :string
  end
end
