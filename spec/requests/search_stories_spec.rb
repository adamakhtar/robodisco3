require 'spec_helper'

describe "SearchStories" do
  describe "when user enters valid search on homepage" do
    it "dispalys search results on search page" do
      user = Factory(:user)
      visit "/"
      page.click_link("sign_in")
      within("form#user_new") do
        fill_in("user_username", :with => user.username)
        fill_in("user_password", :with => user.password)
        click_button("user_submit")
      end
      
      within("form#search_form") do
        fill_in("query", :with => "michael jackson")
        click_button("search_submit")
      end

      current_path.should == "/search_results"
      page.should have_content("Michael Jackson")
    end
  end

  describe "when user enters invalid search from homepage" do
    it "dispalys no results found on search page" do
      user = Factory(:user)
      visit "/"
      page.click_link("sign_in")
      within("form#user_new") do
        fill_in("user_username", :with => user.username)
        fill_in("user_password", :with => user.password)
        click_button("user_submit")
      end
      
      within("form#search_form") do
        fill_in("query", :with => ";;;..,,,")
        click_button("search_submit")
      end

      current_path.should == "/search_results"
      page.should have_content("No Results")
    end
  end


end
