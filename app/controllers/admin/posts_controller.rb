class Admin::PostsController < AdminController

  def index
    @posts = Post.order("updated_at desc").all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new()
    @admin_post_path = admin_posts_path()
  end

  def edit
    @post = Post.find(params[:id])
    @admin_post_path = admin_post_path(@post)
  end

  def create
    @post = Post.new(params.require(:post).permit!)

    if @post.save
      redirect_to edit_admin_post_path(@post), notice: "Post created successfully"
    else
      render action: "new"
    end
  end

  def update
    @post = Post.find(params[:id])
    logger.info @post

    if @post.update_attributes(params.require(:post).permit!)
      redirect_to edit_admin_post_path(@post), notice: "Post updated successfully"
    else
      render action: "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "Post has been deleted"
    redirect_to "/admin"
  end

end
