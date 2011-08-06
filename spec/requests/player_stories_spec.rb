require 'spec_helper'

describe "PlayerStories" do
  describe "when user selects album" do
    it "shows all the albums tracks" do
      thriller_album_id = "959272f9-97ae-4179-aebe-950eef64ed93"
      log_in
      visit play_album_path(:mb_id => thriller_album_id)
      current_path.should match /#{play_album_path}/

      page.should have_selector("#track_listing")
      page.find("#track_listing").should have_selector("li")
    end
  end
end
