class Url < ActiveRecord::Base

  belongs_to :post

  validates :slug, uniqueness: true

  scope :canonical, -> { where(canonical: true) }
  scope :newest, -> { order("updated_at desc") }
end
