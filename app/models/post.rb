class Post < ActiveRecord::Base

  has_many :revisions, dependent: :destroy
  has_many :urls, dependent: :destroy

  accepts_nested_attributes_for :revisions, :urls

  def self.from_slug(slug)
    Url.find_by(slug: slug).post
  end

  def title
    revisions.newest.first.title
  end

  def content
    revisions.newest.first.content
  end

  def slug
    urls.canonical.first.slug
  end

  def published_at
    revisions.published.newest.pluck(:updated_at)
  end

  def published?
    revisions.pluck(:published).inject(false) {|m,x| m || x}
  end

end
