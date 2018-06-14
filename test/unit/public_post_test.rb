require "test_helper"

class PublicPostTest < ActiveSupport::TestCase

  def test_can_list_index_posts
    subject = PublicPost.index()
    assert_equal 2, subject.count
  end

  def test_can_list_by_page
    page_id = PublicPost.find(posts("codename-obtvse").id).date_page
    subject = PublicPost.list(page_id)
    assert_includes subject, posts("codename-obtvse")
  end

  def test_has_only_published_content
    subject = PublicPost.from_slug("a-modest-proposal")
    assert_equal "...for Preventing the Children of Poor People From Being a Burden on Their Parents or Country, and for Making Them Beneficial to the Publick", subject.content
  end

  def test_has_only_published_title
    subject = PublicPost.from_slug("a-modest-proposal")
    assert_equal "A Modest Proposal", subject.title
  end

  def test_knows_next_oldest_valid_page
    
  end

end
