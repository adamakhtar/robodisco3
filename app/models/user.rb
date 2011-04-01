class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :invitable

  attr_accessible :username, :email, :password, :password_confirmation

  has_and_belongs_to_many(:albums)
  has_and_belongs_to_many(:roles)

  validates_uniqueness_of :username
  validates_length_of     :username, :in => 3..20

  after_initialize :set_invitation_limit
  before_create { self.roles << Role.find_or_create_by_name(:user) }

  def role?(name)
    self.roles.exists?(:name => name)
  end

  private

  def set_invitation_limit
    self.invitation_limit = 0 unless self.invitation_limit
  end
end
