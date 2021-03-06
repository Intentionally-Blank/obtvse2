class Revision < ApplicationRecord

  belongs_to :post

  validates :title, :content, presence: true

  scope :newest, -> { order("updated_at desc") }
  scope :published, -> { where(published: true) }

  after_create do
    self.post.touch if self.published?
  end
end
