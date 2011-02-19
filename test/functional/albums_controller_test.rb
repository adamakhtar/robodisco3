require 'test_helper'

class AlbumsControllerTest < ActionController::TestCase
  setup do
    @user  = Factory(:user)
    @album = @user.albums.create(Factory.attributes_for(:album))
  end

  context ":get to :index" do
    context "when logged in" do
      setup do
        sign_in(@user)
        get :index, :user_id => @user.id
      end
      should assign_to(:user)
      should assign_to(:albums)
      should respond_with(:success)
      should render_template(:index)
    end

    context "when logged out" do
      setup do
        get :index, :user_id => @user.id
      end
      should assign_to(:user)
      should assign_to(:albums)
      should respond_with(:success)
      should render_template(:index)
    end
  end


end
