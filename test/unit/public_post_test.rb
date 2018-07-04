require "test_helper"

class PublicPostTest < ActiveSupport::TestCase

  def test_can_list_index_posts
    subject = PublicPost.index()
    assert_equal 3, subject.count
  end

  def test_can_list_by_page
    post    = PublicPost.from_slug("codename-obtvse")
    page_id = post.date_page
    subject = PublicPost.list(page_id)
    assert_includes subject, post
  end

  def test_has_only_published_content
    subject = PublicPost.from_slug("a-modest-proposal")
    assert_equal "...for Preventing the Children of Poor People From Being a Burden on Their Parents or Country, and for Making Them Beneficial to the Publick", subject.content
  end

  def test_has_only_published_title
    subject = PublicPost.from_slug("a-modest-proposal")
    assert_equal "A Modest Proposal", subject.title
  end

  def test_has_a_lede
    subject = PublicPost.from_slug("moral-letters-to-lucilius-36")
    lede = "Encourage your friend to despise stout-heartedly those who upbraid him because he has sought the shade of retirement and has abdicated his career of honours, and, though he might have attained more, has preferred tranquillity to them all. Let him prove daily to these detractors how wisely he has looked out for his own interests. Those whom men envy will continue to march past him; some will be pushed out of the ranks, and others will fall. Prosperity is a turbulent thing; it torments itself. It stirs the brain in more ways than one, goading men on to various aims, – some to power, and others to high living. Some it puffs up; others it slackens and wholly enervates."
    assert_equal lede, subject.lede
  end

end
