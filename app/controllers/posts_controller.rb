class PostsController < ApplicationController

  def index
    if params[:page]
      @posts = PublicPost.list(params[:page])
    else
      @posts = PublicPost.index
    end

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
