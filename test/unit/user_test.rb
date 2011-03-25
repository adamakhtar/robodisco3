require 'test_helper'

class UserTest < ActiveSupport::TestCase
  subject { Factory(:user) }
  should have_and_belong_to_many(:albums)
  should have_and_belong_to_many(:roles)

  should validate_uniqueness_of :username
  should ensure_length_of(:username).is_at_least(3).is_at_most(20)

  context "role?" do
    setup do
      @user = Factory(:user)
      @role = Factory(:role)
    end

    should "given user with a role should return true" do
      @user.roles << @role
      assert @user.role?(@role.name)
    end

    should "given user without a role should return false" do
      assert_false @user.role?(@role.name)
    end
  end
end
