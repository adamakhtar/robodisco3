require 'spec_helper'

describe "Player" do
  context "when user selects album" do
    use_vcr_cassette("play_album_thriller_cassette")
    before(:each) do
      thriller_album_id = "959272f9-97ae-4179-aebe-950eef64ed93"
      log_in
      visit play_album_path(:mb_id => thriller_album_id)
      current_path.should match /#{play_album_path}/
    end

    it "loads the album in the player" do
      page.find(".album_name").should have_content("Thriller")
    end

    
    it "shows all the albums tracks" do
      page.should have_selector("#track_listing")
      page.find("#track_listing").should have_selector("li")
    end


    it "shows other users recent albums", :js => true do 
      page.should have_selector("#related_albums")
      page.find("#related_albums").should have_selector("li")
    end
  end


end
