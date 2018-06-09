class RevisionDiffService < SimpleDelegator

  def output
    if diff == '<div class="diff"></div>'
      "This revision is equal to the live version"
    else
      diff
    end
  end

private

  def left
    content
  end

  def right
    PublicPost.find(post.id).content
  end

  def diff
    @_diff ||= Diffy::Diff.new(left, right).to_s(:html_simple)
  end
end
