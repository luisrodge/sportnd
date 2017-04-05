require 'test_helper'

class Profile::VenuesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get profile_venues_new_url
    assert_response :success
  end

end
