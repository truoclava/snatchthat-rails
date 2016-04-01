# == Schema Information
#
# Table name: activities
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  action         :string
#  trackable_id   :integer
#  trackable_type :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Activity < ActiveRecord::Base
  belongs_to :user

  belongs_to :trackable, polymorphic: true

end
