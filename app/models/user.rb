class User < ActiveRecord::Base
  has_many :rounds
  has_many :authentications
  validates :username, :uniqueness => true
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :country
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable

  def current_round
    rounds.last
  end
  
end
