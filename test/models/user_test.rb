require 'test_helper'

class UserTest < ActiveSupport::TestCase
   test "users should have appropriate properties" do
    user = User.first
    assert user.valid?, "user should be valid"
    user.first_name = nil
    assert_not user.valid?, "user must haz first_name, so they are no longer valid"
    user = User.first
    user.last_name = nil
    assert_not user.valid?, "user must haz last_name, so they are no longer valid"
    user = User.first
    user.email = nil
    assert_not user.valid?, "user must haz email, so they are no longer valid"

   end
end
