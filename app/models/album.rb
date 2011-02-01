class Album < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates_presence_of :title
  validates_presence_of :artist

end
