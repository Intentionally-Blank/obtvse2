class PublicPost < Post

  # The 'index' page of posts
  def self.index
    Post.
      distinct.
      joins(:revisions).
      where(revisions: {published: true}).
      newest.
      limit(8).
      all
  end

  # Date based pagination year and month
  #
  # @param page [String] page at "year-month"
  # @return [Array<PublicPost>]
  def self.list(page)
    year, month = page.split("-")
    Post.
      distinct.
      where('extract(year from "posts".updated_at) = ? and extract(month from "posts".updated_at) = ? ', year, month).
      joins(:revisions).
      where(revisions: {published: true}).
      newest.
      all
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

  def date_page
    updated_at.strftime("%Y-%m")
  end
end
