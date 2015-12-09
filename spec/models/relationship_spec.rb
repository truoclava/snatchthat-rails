# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Relationship do
  before :each do
    @relationship = Relationship.new(follower_id: 1, followed_id: 2)
end

  describe "#new" do 
    it "should be valid" do
      expect(@relationship).to be_valid
    end
    it "should require a follower_id" do
      @relationship.follower_id = nil
      expect(@relationship).to be_invalid
    end
    it "should require a followed_id" do
      @relationship.followed_id = nil
      expect(@relationship).to be_invalid
    end
  end

end
