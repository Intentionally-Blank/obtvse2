class PostsController < ApplicationController

  def index
    @posts = PublicPost.list(page: params[:page])

    respond_to do |format|
      format.html
      format.rss { render layout: false }
    end
  end

  def show
    @post = PublicPost.from_slug(params[:slug])
    not_found and return unless @post.published?
    redirect_to post_url(slug: @post.slug) unless params[:slug] == @post.slug
  end
end
