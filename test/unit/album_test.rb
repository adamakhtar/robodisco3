require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  subject { Factory(:album) }

  should have_and_belong_to_many(:users)

  should validate_presence_of(:title)
  should validate_presence_of(:artist)
  should validate_presence_of(:mb_id)
  should validate_uniqueness_of(:mb_id)

  should "serialize array of track titles" do
    @tracks = ["man in the mirror", "bad"]
    @album = Factory(:album, :tracks => @tracks)
    @album.reload

    assert_equal @tracks, @album.tracks
  end


end
