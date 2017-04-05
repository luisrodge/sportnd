require 'test_helper'

class Profile::EnrollmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get profile_enrollments_new_url
    assert_response :success
  end

end
