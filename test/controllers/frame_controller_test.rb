require 'test_helper'

class FrameControllerTest < ActionDispatch::IntegrationTest
  test "should get intext," do
    get frame_intext,_url
    assert_response :success
  end

  test "should get analysis," do
    get frame_analysis,_url
    assert_response :success
  end

  test "should get sinon" do
    get frame_sinon_url
    assert_response :success
  end

end
