require "test_helper"
require "support/jwt_support"

class TokenValidationServiceTest < ActiveSupport::TestCase

  def test_token_with_valid_payload_is_valid
    subject = TokenValidationService.new(token_for_payload(valid_payload),
                                         @valid_info)
    assert subject.valid?
  end

  def test_token_from_other_issuer_is_not_valid
    invalid_payload = valid_payload.tap { |x| x[:iss] = "someone-else" }
    subject = TokenValidationService.new(token_for_payload(invalid_payload),
                                         @valid_info)
    assert_not subject.valid?
  end

  def test_expired_is_not_valid
    invalid_payload = valid_payload.tap { |x| x[:exp] = Time.now.to_i - 10 }
    subject = TokenValidationService.new(token_for_payload(invalid_payload),
                                         @valid_info)
    assert_not subject.valid?
  end

  def test_too_early_is_not_valid
    invalid_payload = valid_payload.tap { |x| x[:nbf] = Time.now.to_i + 100 }
    subject = TokenValidationService.new(token_for_payload(invalid_payload),
                                         @valid_info)
    assert_not subject.valid?
  end

  def test_token_for_other_audience_is_not_valid
    invalid_payload = valid_payload.tap { |x| x[:aud] = "someone-else" }
    subject = TokenValidationService.new(token_for_payload(invalid_payload),
                                         @valid_info)
    assert_not subject.valid?
  end

  def test_issued_in_future_is_not_valid
    invalid_payload = valid_payload.tap { |x| x[:iat] = Time.now.to_i + 100 }
    subject = TokenValidationService.new(token_for_payload(invalid_payload),
                                         @valid_info)
    assert_not subject.valid?
  end

  def test_sub_grant_is_available
    subject = TokenValidationService.new(token_for_payload(valid_payload),
                                         @valid_info)
    assert_equal valid_payload()[:sub],  subject.grants[:sub]
  end

end
