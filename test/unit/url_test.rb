require "test_helper"

class UrlTest < ActiveSupport::TestCase

  def test_slug_gets_urlified
    assert_equal "some-cow-funk", Url.new(slug: "Some Cow Funk").slug
  end
end
