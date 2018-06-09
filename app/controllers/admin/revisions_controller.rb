class Admin::RevisionsController < AdminController

  def index
    @revisions = Post.find(params[:post_id]).revisions.order("updated_at desc")
  end

  def show
    @diff = RevisionDiffService.new(Revision.find(params[:id]))
  end
end
