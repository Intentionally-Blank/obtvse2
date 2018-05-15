require "test_helper"
require "support/jwt_support"

class UsersControllerTest < ActionController::TestCase

  def test_login_with_valid_token
    @controller.valid_against = @valid_info
    post :create, params: {jwt: token_for_payload(valid_payload)}
    assert valid_payload[:sub], session[:user]
    assert "Successfully Logged In", flash[:notice]
    assert_response :redirect
  end

  def test_login_with_invalid_token
    @controller.valid_against = @valid_info
    invalid_payload = valid_payload.tap { |x| x[:iss] = "someone-else" }
    post :create, params: {jwt: token_for_payload(invalid_payload)}
    assert "JWT not valid!", flash[:error]
    assert_response :ok
  end
end
