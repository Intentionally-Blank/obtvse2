class Revision < ActiveRecord::Base

  belongs_to :post

  validates :title, :content, presence: true

  scope :newest, -> { order("updated_at desc") }
  scope :published, -> { where(published: true) }

end
