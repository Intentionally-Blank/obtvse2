require "test_helper"

class Admin::PostsControllerTest < ActionController::TestCase

  # Redefine authenticate for this request.  Useful for stubbing
  # out authentication behavior that you may not want to test.
  def as_an_admin
    @controller.session[:user] = "someone"
  end

  def test_spies_cannot_use_the_admin_list
    get :index
    assert_response :unauthorized
  end

  def test_haters_cannot_hate
    delete :destroy, params: { id: posts("codename-obtvse").id }
    assert_response :unauthorized
  end

  def test_haters_cannot_even_try_to_hate
    delete :destroy, params: { id: 0 }
    assert_response :unauthorized
  end

  def test_vandals_cannot_vandalize_by_updating
    put :update, params: { id: posts("codename-obtvse").id, post: {content: "all your base are belong to us"} }
    assert_response :unauthorized
  end

  def test_vandals_cannot_vandalize_by_creating
    post :create, params: { post: { slug: "im-with-stupid", content: "again, all your base are belong to us" } }
    assert_response :unauthorized
  end

  def test_admin_can_get_the_admin_view
    as_an_admin
    get :index
    assert_response :ok
  end

  def test_admin_can_new_a_post
    as_an_admin
    get :new
    assert_response :ok
  end

  def test_admin_can_create_a_post
    as_an_admin
    post :create, params: { post: valid_post_attributes }
    assert_response :redirect
  end

  def test_admin_can_edit_a_post
    as_an_admin
    post = posts("a-modest-proposal")
    get :edit, params: { id: post.id }
    assert_response :ok
  end

  def test_admin_can_update_a_post
    as_an_admin
    attrs = valid_post_attributes
    attrs[:revisions_attributes].first[:content] = "It is a melancholy object to those, who walk through this great town, or travel in the country"
    assert_changes -> { Post.find(posts("a-modest-proposal").id).revisions.count } do
      put :update, params: { id: posts("a-modest-proposal").id, post: attrs }
    end
    assert_response :redirect
  end

  def test_admin_can_delete_a_post
    as_an_admin
    delete :destroy, params: { id: posts("a-modest-proposal").id }
    assert_response :found
  end

end
