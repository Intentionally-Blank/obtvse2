class PublicPost < Post

  def self.list(page: 1, per: 8)
    Revision.
      published.
      newest.
      page(page).
      per(per).
      map(&:post_id).
      uniq.
      map {|id| find(id)}
  end

  def self.from_slug(slug)
    self.find(Url.find_by(slug: slug).post_id)
  end

  def title
    revisions.published.newest.first.title
  end

  def content
    revisions.published.newest.first.content
  end
end
