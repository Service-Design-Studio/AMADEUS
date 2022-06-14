require "test_helper"

class UploadFileControllerTest < ActionDispatch::IntegrationTest
  test "should get upload" do
    get upload_file_upload_url
    assert_response :success
  end
end
