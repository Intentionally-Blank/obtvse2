class Post < ActiveRecord::Base

  has_many :revisions
  has_many :urls

  def self.from_slug(slug)
    Url.find_by(slug: slug).post
  end

  def title
    revisions.published.newest.first.title
  end

  def content
    revisions.published.newest.first.content
  end

  def slug
    urls.canonical.first.slug
  end


end
