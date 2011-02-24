require 'test_helper'

class TrackTest < ActiveSupport::TestCase

  should have_and_belong_to_many :albums
  should "save factory" do
    @track = Factory(:track)
    assert !@track.new_record?
  end

  should "remove brackets and excess whitespace padding from title on save" do
    title = "Sade (Group w/ singer of same performance name)"
    assert_equal "Sade", Factory(:track, :title => title).title
  end


end
