require 'spec_helper'

describe "SearchStories" do
  describe "when user enters valid search on homepage" do
    it "dispalys search results on search page" do
      log_in     
      search_for("michael jackson")

      current_path.should == "/search_results"
      page.should have_content("Michael Jackson")
    end
  end

  describe "when user enters invalid search from homepage" do
    it "dispalys no results found on search page" do
      log_in
      search_for(";;:::xcvcv:d:") #a query guaranteed to not have any results

      current_path.should == "/search_results"
      page.should have_content("No Results")
    end
  end

  describe "when user enters valid search on search page" do
    it "displays search results on search page" do
      log_in
       search_for("michael jackson")

      current_path.should == "/search_results"
      page.should have_content("Michael Jackson")
    end
  end
end
