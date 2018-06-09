class Admin::UrlsController < AdminController

  def index
    @urls = Post.find(params[:post_id]).urls.newest
  end
end
