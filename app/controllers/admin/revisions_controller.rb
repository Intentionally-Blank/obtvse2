class Admin::RevisionsController < AdminController

  def index
    @revisions = Post.find(params[:post_id]).revisions.newest
  end

  def show
    @diff = RevisionDiffService.new(Revision.find(params[:id]))
  end
end
