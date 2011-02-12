require 'test_helper'

class PlayerControllerTest < ActionController::TestCase
      
  context "show action" do
    should "render show template" do
      get :show, :id => Player.first
      assert_template 'show'
    end
  end    
              
end
