require 'test_helper'

class Profile::TeamsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get profile_teams_index_url
    assert_response :success
  end

end
