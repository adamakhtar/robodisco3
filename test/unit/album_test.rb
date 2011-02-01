require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  should have_and_belong_to_many(:users)

  should validate_presence_of(:title)
  should validate_presence_of(:artist)
end
