INFO = HashWithIndifferentAccess.new(
  {
    title:  ENV['TITLE'],
    domain: ENV['DOMAIN'],
    name:   ENV['NAME'],
    email:  ENV['EMAIL'],
    about:  ENV['ABOUT'],
    aud:    ENV['AUD'],
    iss:    ENV['ISS'],
    cert:   ENV['CERT']
  }
)
