class Post < ActiveRecord::Base

  has_many :revisions, dependent: :destroy
  has_many :urls, dependent: :destroy

  accepts_nested_attributes_for :revisions
  accepts_nested_attributes_for :urls,
                                reject_if: :has_existing_slug


  def self.from_slug(slug)
    Url.find_by(slug: slug).post
  end

  def has_existing_slug(attr)
    Url.where(slug: attr[:slug], post_id: id).count > 0
  end

  def title
    revisions.newest.first.title
  end

  def content
    revisions.newest.first.content
  end

  def slug
    urls.canonical.first.try(:slug) || urls.newest.first.slug
  end

  def published_at
    revisions.published.newest.pluck(:updated_at)
  end

  def published?
    revisions.pluck(:published).inject(false) { |m, x| m || x }
  end

end
