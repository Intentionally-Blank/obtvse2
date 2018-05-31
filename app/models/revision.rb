class Revision < ActiveRecord::Base

  belongs_to :post

  validates :title, :content, presence: true

  scope :published, -> { where(published: true) }

end
