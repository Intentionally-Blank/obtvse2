class PostsController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def index
    @posts = Post.published.newest.page(params[:page]).per(8)

    respond_to do |format|
      format.html
      format.rss { render layout: false }
    end
  end

  def show
    @single_post = true
    @post = Post.from_slug(params[:slug])

    if @post.nil? || (@post.draft && !logged_in?)
      not_found
    else
      @next = Post.next(@post).last
      @previous = Post.previous(@post).first

      respond_to do |format|
        if @post.present?
          format.html
        else
          format.any { render status: 404  }
        end
      end
    end
  end

  def admin
    @posts = Post.order("updated_at desc").all
  end

  def new
    @post = Post.new(title: params[:title] || "")
    @post_path = "/"

    respond_to do |format|
      format.html
    end
  end

  def edit
    @post = Post.from_slug(params[:slug])
    @post_path = post_path(@post)
  end

  def create
    @post = Post.new(params.require(:post).permit!)

    respond_to do |format|
      if @post.save
        format.html { redirect_to edit_post_path(slug: @post.slug), notice: "Post created successfully" }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @post = Post.from_slug(params[:slug])
    logger.info @post

    respond_to do |format|
      if @post.update_attributes(params.require(:post).permit!)
        format.html { redirect_to edit_post_path(slug: @post.slug), notice: "Post updated successfully" }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @post = Post.from_slug(params[:slug])
    @post.destroy
    flash[:notice] = "Post has been deleted"

    respond_to do |format|
      format.html { redirect_to "/admin" }
    end
  end

private

  def require_login
    unless session[:user]
      render_unauthorized && return
    end
  end
end
