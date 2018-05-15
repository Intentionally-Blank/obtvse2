class TokenValidationService

  attr_reader :grants
  # Validates a JWT and holds its state (valid? && the grants)
  #
  # @param token [String] the JSON Web Token to be validated
  # @param valid_against [Hash] must contain :iss, :aud, :cert to verify against
  # @return [TokenValidationService]
  def initialize(token, valid_against)
    @valid = true
    rsa = OpenSSL::X509::Certificate.new(valid_against[:cert])
    begin
      grants = JWT.decode(token,
                          rsa.public_key,
                          true,
                          { algorithm: "RS256",
                            iss: valid_against[:iss],
                            verify_iss: true,
                            aud: valid_against[:aud],
                            verify_aud: true,
                            verify_iat: true
                          })
      @grants = HashWithIndifferentAccess.new(grants.first)
    rescue JWT::DecodeError => e
      Rails.logger.error e
      @valid = false
    end
  end

  def valid?
    @valid
  end
end
