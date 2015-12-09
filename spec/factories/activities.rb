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

FactoryGirl.define do
  factory :activity do
    user nil
action "MyString"
trackable nil
  end

end
