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

  attr_accessor :login

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

  private
  def create_board
    Board.create(user_id: self.id)
  end
end
