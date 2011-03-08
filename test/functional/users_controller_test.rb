require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = Factory(:user)
  end

  context ":get to index" do
    setup do
      get :index
    end

    should respond_with :success
    should assign_to(:users)
  end

  context ":post to create" do
    context "given valid credentials" do
      setup do
        @credentials = Factory.attributes_for(:user)
        post :create, :user => @credentials
      end

      should "save record in db" do
        assert User.find_by_username(@credentials[:username])
      end
    end

    context "given invalid credentials" do
      setup do
        @credentials = Factory.attributes_for(:user, :username => "a")
        post :create, :user => @credentials
      end

      should "not save record in db" do
        assert_nil User.find_by_username(@credentials[:username])
      end
    end
  end



  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => Factory.attributes_for(:user)
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, :id => @user.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @user.to_param
    assert_response :success
  end

  test "should update user" do
    put :update, :id => @user.to_param, :user => @user.attributes
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, :id => @user.to_param
    end

    assert_redirected_to users_path
  end
end
