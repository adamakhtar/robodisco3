require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  should have_and_belong_to_many(:users)
end
