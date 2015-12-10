# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  phone_number           :string
#  notifications          :boolean          default(TRUE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  slug                   :string
#  username               :string
#

require 'spec_helper'

describe User do
  before :each do
    @michael = User.new(id: 1, username: "michael", email: "helloiammichael@hello.com", phone_number: "2837465290", password: "passwordpassword")
    @archer  = User.new(id: 2, username: "archer", email: "helloiamarcher@archer.com", phone_number: "2837465290",password: "passwordpasswordpass")
    @michael.save
    @archer.save
end

  describe "#user" do
    it "should initially not be following a user" do
      expect(@michael.following?(@archer)).to be false
    end
    it "should be able to follow a user" do
      @michael.follow(@archer)
      expect(@michael.following?(@archer)).to be true
    end
    it "should be able to unfollow a user" do
      @michael.follow(@archer)
      @michael.unfollow(@archer)
      expect(@michael.following?(@archer)).to be false
    end
    it "should be able to tell who their followers are" do
      @michael.follow(@archer)
      expect(@archer.followers.include?(@michael)).to be true
    end
  end
end

