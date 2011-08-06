require 'spec_helper'

describe "SearchStories" do
  describe "when user enters valid search on homepage" do
    use_vcr_cassette("valid_search_cassette")
    it "dispalys search results on search page" do
      log_in     
      search_for("michael jackson")

      current_path.should == "/search_results"
      page.should have_content("Michael Jackson")
    end
  end

  describe "when user enters invalid search from homepage" do
    use_vcr_cassette("invalid_search_cassette")
    it "dispalys no results found on search page" do
      log_in
      search_for(";;:::xcvcv:d:") #a query guaranteed to not have any results

      current_path.should == "/search_results"
      page.should have_content("No Results")
    end
  end

  describe "when user enters valid search on search page" do
    use_vcr_cassette("valid_search_cassette")
    it "displays search results on search page" do
      log_in
       search_for("michael jackson")

      current_path.should == "/search_results"
      page.should have_content("Michael Jackson")
    end
  end

  describe "when user clicks on search result on search page" do
    use_vcr_cassette("valid_search_cassette")
    it "shows the album in the player" do
      log_in
      search_for("michael jackson")

      current_path.should == "/search_results"
      page.first(".result_box a").click

      current_path.should match %r{player/show}
    end
  end
end
