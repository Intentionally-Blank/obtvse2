require "test_helper"

class PostsControllerTest < ActionController::TestCase

  # Redefine authenticate for this request.  Useful for stubbing
  # out authentication behavior that you may not want to test.
  def as_an_admin
    @controller.session[:user] = "someone"
  end

  def valid_post_attributes
    {
      slug: "a-tale-of-two-cities",
      title: "A Tale of Two Cities",
      content: "It was the best of times",
      draft: false
    }
  end

  def test_anyone_can_list_the_posts
    get :index
    published = posts("codename-obtvse")
    assert assigns(:posts).map(&:id).include?(published.id), "Posts should include published posts"
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
