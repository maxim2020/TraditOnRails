require 'test_helper'

class TradeControllerTest < ActionController::TestCase
  test "should get init" do
    get :init
    assert_response :success
  end

end
