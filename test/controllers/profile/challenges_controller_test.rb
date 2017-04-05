require 'test_helper'

class Profile::ChallengesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get profile_challenges_index_url
    assert_response :success
  end

end
