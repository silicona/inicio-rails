require 'test_helper'

class SesionesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get acceder_url
    assert_response :success
  end

end
