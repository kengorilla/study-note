require 'test_helper'

class QuizControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get quiz_home_url
    assert_response :success
  end

end
