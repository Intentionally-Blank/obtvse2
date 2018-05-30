require "test_helper"

class PublicPostTest < ActiveSupport::TestCase

  def test_can_list_published_posts
    subject = PublicPost.list()
    assert_equal 2, subject.count
  end

  def test_has_only_published_content
    subject = PublicPost.from_slug("a-modest-proposal")
    assert_equal "...for Preventing the Children of Poor People From Being a Burden on Their Parents or Country, and for Making Them Beneficial to the Publick", subject.content
  end

  def test_has_only_published_title
    subject = PublicPost.from_slug("a-modest-proposal")
    assert_equal "A Modest Proposal", subject.title
  end

end
