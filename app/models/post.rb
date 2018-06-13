class Post < ApplicationRecord

  has_many :revisions, dependent: :destroy
  has_many :urls, dependent: :destroy

  accepts_nested_attributes_for :revisions
  accepts_nested_attributes_for :urls,
                                reject_if: :has_existing_slug


  def self.from_slug(slug)
    Url.find_by(slug: slug).post
  end

  def has_existing_slug(attr)
    if Url.where(slug: attr[:slug], post_id: id).count > 0
      Url.where(slug: attr[:slug], post_id: id).first.touch
      true
    else
      false
    end
  end

  def current_revision
    revisions.newest.first
  end

  def canonical_url
    urls.newest.first
  end

  def title
    current_revision.title
  end

  def content
    current_revision.content
  end

  def slug
    canonical_url.slug
  end

  def published_at
    revisions.published.newest.pluck(:updated_at)
  end

  def published?
    revisions.pluck(:published).inject(false) { |m, x| m || x }
  end

end
