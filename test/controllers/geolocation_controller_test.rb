require 'test_helper'

class GeolocationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get geolocation_index_url
    assert_response :success
  end

end
