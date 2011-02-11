require 'test_helper'

class TrackTest < ActiveSupport::TestCase

  should have_and_belong_to_many :albums
  should "save factory" do
    @track = Factory(:track)
    assert !@track.new_record?
  end
end
