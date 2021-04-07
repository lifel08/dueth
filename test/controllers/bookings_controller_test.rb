require "test_helper"

class BookingsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get bookings_create_url
    assert_response :success
  end

  test "should get destroy" do
    get bookings_destroy_url
    assert_response :success
  end

  test "should get accept" do
    get bookings_accept_url
    assert_response :success
  end

  test "should get decline" do
    get bookings_decline_url
    assert_response :success
  end
end
