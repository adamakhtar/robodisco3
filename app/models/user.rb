class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :username, :email, :password, :password_confirmation

  has_and_belongs_to_many(:albums)

  validates_uniqueness_of :username
  validates_length_of     :username, :in => 3..20
end
