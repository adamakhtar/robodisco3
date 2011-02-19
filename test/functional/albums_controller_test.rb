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

  context ":get to :toggle_favourite" do
    context "when user logged in" do
      setup do
        sign_in @user
      end

      context "when album already favourited" do
        setup do
          xhr :post, :toggle_favourite, :user_id => @user.id, :id => @album.id
        end

        should render_template(:toggle_favourite)

        should "unfavourite the album" do
          assert_nil @user.albums.find_by_id(@album.id)
        end

        should "not destroy the album" do
          assert Album.find_by_id(@album.id)
        end
      end

      context "when album is not in user favourites" do
        setup do
          @new_album = Factory(:album)
          xhr :post, :toggle_favourite, :user_id => @user.id, :id => @new_album.id
        end

        should "add album to users favourites" do
          assert @user.albums.find_by_id(@new_album.id)
        end
      end
    end

    context "when user is guest" do
      setup do

      end

      should "render login and signup form" do

      end
    end
  end


end
