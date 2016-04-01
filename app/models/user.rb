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
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
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
  validates_format_of :username, with: /\A[\w\-\.]+\z/
  validates :phone_number, presence: true, length: { is: 10 }, numericality: { only_integer: true }, uniqueness: true

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

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  acts_as_voter
  
  
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
  
  def feed(user_id)
    
    @followed_closets = []
    relationship = Relationship.where(followed_id: id)
      relationship.each do |relation|
        @followed_closets << Closet.where(board_id: relation.follower_id)
        
      end
    return @followed_closets.flatten!
    # following_ids = "SELECT followed_id FROM relationships
    #                    WHERE  follower_id = :board_id"
    # Closet.where("board_id IN (#{following_ids})", board_id: id)
  end

  def activity_feed
   Activity.order("created_at desc")
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
    true
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def notifications?(user_id)
    User.find_by(id: user_id).notifications
  end

  private
  def create_board
    Board.create(user_id: self.id)
  end
end
