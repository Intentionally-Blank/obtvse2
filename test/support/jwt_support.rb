module JWTSupport
  def setup
    @rsa_private = OpenSSL::PKey::RSA.generate 2048
    name = OpenSSL::X509::Name.parse("CN=example.com/C=EE")
    cert = OpenSSL::X509::Certificate.new
    cert.version     = 2
    cert.serial      = 0
    cert.not_before  = Time.now
    cert.not_after   = cert.not_before + 1 * 60 * 60 # 1 hour validity
    cert.public_key  = @rsa_private.public_key
    cert.subject     = name
    cert.issuer      = name
    cert.sign @rsa_private, OpenSSL::Digest::SHA1.new
    @valid_info = { iss:  "http://example.com",
                     aud:  "LoremIpsum",
                     cert: cert.to_pem }
    super
  end

  def token_for_payload(payload)
    JWT.encode payload, @rsa_private, "RS256"
  end

  def valid_payload
    now = Time.now.to_i
    { iss: "http://example.com",
      aud: "LoremIpsum",
      sub: "foobarbaz",
      nbf: now - 1,
      iat: now,
      exp: now + 10
    }
  end
end

module Minitest
  class Test
    include JWTSupport
  end
end
