require "test_helper"

class PostTest < ActiveSupport::TestCase

  def test_has_title
    subject = posts("codename-obtvse")
    assert_equal "Codename: Obtvse", subject.title
  end

  def test_has_content
    subject = posts("codename-obtvse")
    assert_equal "Earlier today I was browsing Hacker News and was a bit let down by a post I ran across by recent HN front-pager", subject.content
  end

  def test_has_unpublished_content
    subject = posts("a-modest-proposal")
    assert_equal "Just Kidding....", subject.content
  end

  def test_has_unpublished_title
    subject = posts("a-modest-proposal")
    assert_equal "A Modest-ish Proposal", subject.title
  end

  def test_has_slug
    subject = posts("codename-obtvse")
    assert_equal "codename-obtvse", subject.slug
  end

  def test_is_findable_by_slug
    assert_equal posts("codename-obtvse"), Post.from_slug("codename-obtvse")
  end

  def test_handles_multiple_publishes
    subject = posts("codename-obtvse")
    assert_equal 2, subject.published_at.count
  end

  def test_delegates_published?
    assert posts("codename-obtvse").published?
    assert posts("a-modest-proposal").published?
    assert_not posts("to-himself").published?
  end
end
