require 'test_helper'

class UserTest < ActiveSupport::TestCase
  subject { Factory(:user) }

  should have_and_belong_to_many(:albums)
  should have_and_belong_to_many(:roles)

  should validate_uniqueness_of :username
  should ensure_length_of(:username).is_at_least(3).is_at_most(20)

  should "set user role to :user before creating record" do
    user = Factory.build(:user)
    assert_false user.role?(:user)
    user.save
    assert user.role?(:user)
  end

  should "set default invitation limit to 0" do
    user = Factory(:user)
    assert_equal 0, user.invitation_limit
  end


  context "role?" do
    setup do
      @user = Factory(:user)
      @role = Factory(:role)
    end

    should "return true when specified role exists" do
      @user.roles << @role
      assert @user.role?(@role.name)
    end

    should "return false when specified role does not exit" do
      assert_false @user.role?(@role.name)
    end
  end
end
