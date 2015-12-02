class User < ActiveRecord::Base
  has_one :board
  has_many :closets, through: :board
    validates :email, presence: true, uniqueness: true
end
