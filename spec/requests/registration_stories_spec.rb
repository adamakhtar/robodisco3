require 'spec_helper'

describe "RegistrationStories" do
  describe "when guest signs up with valid details" do
    it "creates account and takes them back to the homepage" do
      visit "/"
      current_path.should == "/" 
      page.click_link("sign_up")
      within("form#user_new") do
        fill_in("user_username", :with => "validusername")
        fill_in("user_email", :with => "valid@email.com")
        fill_in("user_password", :with => "validpass")
        fill_in("user_password_confirmation", :with => "validpass")
        click_button("user_submit")
      end
      current_path.should == "/"
      page.should have_content("success")
    end
  end

  describe "when guest signs up with invalid details" do
    it "it displays errors on sign up form" do
      visit "/"
      current_path.should == "/" 
      page.click_link("sign_up")

      within("form#user_new") do
        fill_in("user_username", :with => "meh")
        fill_in("user_email", :with => "blah")
        fill_in("user_password", :with => "blah")
        fill_in("user_password_confirmation", :with => "meh")
        click_button("user_submit")
      end
      
      page.should have_content("errors")
    end
  end
 end
