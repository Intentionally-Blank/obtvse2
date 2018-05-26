class Revision < ActiveRecord::Base

  belongs_to :post

  scope :published, -> { where(published: true) }
  scope :newest, -> { order("updated_at desc") }
end
