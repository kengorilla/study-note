require 'test_helper'

class NoteControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get note_new_url
    assert_response :success
  end

end
