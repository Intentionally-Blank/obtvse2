class Url < ApplicationRecord

  belongs_to :post

  validates :slug, uniqueness: true

  scope :canonical, -> { where(canonical: true) }
  scope :newest, -> { order("updated_at desc") }

  def slug=(str)
    super(str.to_url)
  end

end
