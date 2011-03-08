require 'test_helper'

class UserTest < ActiveSupport::TestCase
  subject { Factory(:user) }
  should have_and_belong_to_many(:albums)

  should validate_uniqueness_of :username
  should ensure_length_of(:username).is_at_least(3).is_at_most(20)
end
