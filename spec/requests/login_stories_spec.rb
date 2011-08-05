require 'spec_helper'

describe "LoginStories" do
  describe "when user logins in with valid credentials" do
    it "authenticates and returns to homepage" do
      user = Factory(:user)
      visit "/"
      current_path.should == "/" 
      page.click_link("sign_in")
      within("form#user_new") do
        fill_in("user_username", :with => user.username)
        fill_in("user_password", :with => user.password)
        click_button("user_submit")
      end
      current_path.should == "/"
      page.should have_content("success")
    end
  end

  describe "when user logins in with invalid credentials" do
    it "reshows the login form" do 
      visit "/"
      current_path.should == "/" 
      page.click_link("sign_in")
      within("form#user_new") do
        fill_in("user_username", :with => "noexist")
        fill_in("user_password", :with => "noexist")
        click_button("user_submit")
      end
      current_path.should == "/users/sign_in"
      page.should have_content("Invalid")
    end
  end 
end
