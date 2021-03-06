def log_in(user=nil)
  user ||= Factory(:user)
  visit "/"
  page.click_link("sign_in")
  within("form#user_new") do
    fill_in("user_username", :with => user.username)
    fill_in("user_password", :with => user.password)
    click_button("user_submit")
  end
  current_path.should == "/"
  page.should have_content("Signed in")
end

def search_for(query)
  within("form#search_form") do
    fill_in("query", :with => query)
    click_button("search_submit")
  end
end
