require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  subject { Factory(:album) }

  should have_and_belong_to_many(:users)
  should have_and_belong_to_many(:tracks)

  should validate_presence_of(:title)
  should validate_presence_of(:artist)
  should validate_presence_of(:mb_id)
  should validate_uniqueness_of(:mb_id)
end
