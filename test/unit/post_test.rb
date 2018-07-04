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

  def test_is_findable_by_old_slug
    subject = Post.from_slug("a-proposal")
    assert_equal posts("a-modest-proposal"), subject
  end

  def test_most_recent_slug_is_canonical
    subject = Post.from_slug("a-proposal")
    assert_equal "a-modest-proposal", subject.slug
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

  def test_updating_with_identical_data
    subject = Post.create(valid_post_attributes)
    subject.update(valid_post_attributes)
    subject.reload
    assert_equal 2, subject.revisions.count
    assert_equal 1, subject.urls.count
  end

  def test_updating_with_identical_data_updates_url
    subject = Post.create(valid_post_attributes)
    subject.update(valid_post_attributes)
    subject.reload
    assert_not_equal subject.urls.first.created_at, subject.urls.first.updated_at
  end

  def test_updating_published_touches_post_updated_at
    subject = posts("to-himself")
    subject.update({
                     urls_attributes: [{slug: "to-himself"}],
                     revisions_attributes: [{
                                              title:     "Meditations",
                                              content:   "Everything we hear is an opinion, not a fact.",
                                              published: true
                                            }]
                   })
    subject.reload
    assert_equal subject.updated_at, subject.revisions.newest.first.updated_at
  end

  def test_updating_published_touches_post_updated_at
    subject = posts("to-himself")
    match   = revisions("himself-v1").updated_at
    subject.update({
                     urls_attributes: [{slug: "to-himself"}],
                     revisions_attributes: [{
                                              title:     "Meditations",
                                              content:   "Everything we hear is an opinion, not a fact.",
                                              published: false
                                            }]
                   })
    subject.reload
    assert_equal match, subject.updated_at
  end

  def test_duplicates_are_rejected
    Post.create(valid_post_attributes)
    subject = Post.create(valid_post_attributes)
    assert_not subject.persisted?
  end

end
