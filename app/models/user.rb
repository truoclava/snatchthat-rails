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
#  phone_number           :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  slug                   :string
#  username               :string
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  extend FriendlyId
  friendly_id :username, use: [:slugged, :finders]

  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :trackable,
       :validatable, :authentication_keys => [:login]

  validate :validate_username

  # validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/


  after_create :create_board

  has_one :board
  has_many :closets, through: :board
  has_many :closet_items, through: :closets
  has_many :items, through: :closet_items
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  # has_many :followers, through: :passive_relationships, source: :follower
  has_many :followers, through: :passive_relationships
  has_many :activities

  attr_accessor :login

  # Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  def feed

  following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :board_id"
  Closet.where("board_id IN (#{following_ids})", board_id: id)
  end

  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        conditions[:email].downcase! if conditions[:email]
        where(conditions.to_hash).first
      end
  end

  def email_required?
    false
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def notifications?
    current_user.notifications
  end


  private
  def create_board
    Board.create(user_id: self.id)
  end
end
