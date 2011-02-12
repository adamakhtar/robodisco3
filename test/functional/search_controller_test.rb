require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  context "new action" do
    should "render new template" do
      get :new
      assert_template 'new'
    end
  end

  #results
  #fi no search term redirect back to home
  #search term
  #render disply
  context "results action" do
    context "when invalid qeury" do
      setup do
        post :results, :query => ""
      end
      should redirect_to("new search action"){ root_path }
    end

    context "when valid query" do
      setup do
        Album.any_instance.stubs(:search_mbrainz_for).returns(Factory(:album))
        post :results, :query => "michael jackson"
      end
      should assign_to(:albums)
      should respond_with(:success)
      should render_template(:results)
    end
  end
end
