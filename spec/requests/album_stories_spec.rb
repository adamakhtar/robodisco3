require 'spec_helper'

describe "AlbumStories" do

  before(:each) do
    Capybara.default_wait_time = 5
    @current_user = Factory(:user)
    @current_user_album = Factory(:album, :users => [@current_user], :title => "thriller")

    @other_user = Factory(:user)
    @other_user_album = Factory(:album, :users => [@other_user], :title => "bad")

    log_in(@current_user)
    visit user_albums_path(@current_user)
  end
  
  context "GET /album_stories" do
    it "shows users saved albums" do
      page.should have_content(@current_user_album.title)
    end

    it "shows albums saved by other users" do
      page.should have_content(@other_user_album.title)
    end

    it "shows unlike button next to saved albums", :js => true do
      page.execute_script( %q{ $(".favourite_toggle").show(); })
      find("#user_favourites li").should have_css(".favourite_toggle")
    end

    it "shows like button next to other users saved albums", :js => true do 
      page.execute_script( %q{ $(".favourite_toggle").show(); })
      find("#others_favourites li").should have_css(".favourite_toggle")
    end
  end

  context "clicking unlike on saved album", :js => true do
    it "removes album from list" do
      album_listing = "#user_favourites li"
      unlike_option = page.find(:css, "#user_favourites li .favourite_toggle")

      reveal_and_unbind_like_options
      unlike_option.click

      page.should have_no_css(album_listing)
      page.should have_no_content(@current_user_album.title)
    end
  end

  context "clicking like on other users saved albums", :js => true do
    it "adds album to users saved list" do
      like_option = page.find("#others_favourites li .favourite_toggle")

      reveal_and_unbind_like_options
      like_option.click
      
      liked_album = page.find('#user_favourites li:nth-child(2)')
      liked_album.should have_content(@other_user_album.title)
    end
  end

  #workaround for capybara. Capybara cant click on hidden elements
  #and cant programmatically trigger hover events to reveal hidden elements.
  #so instead this will show any hidden buttons and also disable any hover
  #events binded to them to prevent future hassles.
  def reveal_and_unbind_like_options
    page.execute_script( %q{ $("li").unbind("mouseenter").unbind("mouseleave"); $(".favourite_toggle").show(); })
  end

end
