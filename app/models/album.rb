class Album < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :tracks

  validates_presence_of :title
  validates_presence_of :artist
  validates_presence_of :mb_id
  validates_uniqueness_of :mb_id




end
