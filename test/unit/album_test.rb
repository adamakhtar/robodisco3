require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  context "Factory" do
    should "save to db" do
      assert Factory(:album)
    end

  end
end
