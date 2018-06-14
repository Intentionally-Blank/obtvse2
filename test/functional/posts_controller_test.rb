require "test_helper"

class PostsControllerTest < ActionController::TestCase

  def test_anyone_can_list_the_posts
    get :index
    published = posts("codename-obtvse")
    assert assigns(:posts).map(&:id).include?(published.id), "Posts should include published posts"
    assert_response :ok
  end

  def test_anyone_can_page_posts
    page_id = PublicPost.find(posts("codename-obtvse").id).date_page
    get :index, params: { page: page_id }
    published = posts("codename-obtvse")
    assert assigns(:posts).map(&:id).include?(published.id)
    assert_response :ok
  end

  def test_spies_cannot_spy_by_listing_drafts
    get :index
    draft = posts("to-himself")
    assert ! assigns(:posts).include?(draft), "Posts should not include drafts"
    assert_response :ok
  end

  def test_anyone_can_read_a_post
    get :show, params: { slug: "codename-obtvse" }
    assert_response :ok
  end

  def test_spies_cannot_spy_by_reading_drafts
    get :show, params: { slug: "to-himself" }
    assert_response :not_found
  end

  def test_redirects_to_canonical_slug
    get :show, params: { slug: "a-proposal" }
    assert_response :redirect
  end

end
