class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  after_create :create_board
  has_one :board
  has_many :closets, through: :board
  has_many :closet_items, through: :closets
  has_many :items, through: :closet_items

  private
  def create_board
    Board.create(user_id: self.id)
  end
end
